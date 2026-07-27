/**
 * 音乐播放器
 * 浮动在屏幕右侧，可折叠
 * 使用 MetingJS 获取网易云歌单
 */
(function () {
  'use strict';

  // ============== 配置 ==============
  // 网易云歌单 ID（在网易云音乐网页版歌单 URL 中获取，例如 https://music.163.com/playlist?id=123456789）
  const NETEASE_PLAYLIST_ID = '866776925';  // 网易云歌单 ID
  // Meting API 服务地址（支持 CORS 的公开代理列表）
  const METING_APIS = [
    'https://api.i-meto.com/meting/api',
    'https://meting-api.vercel.app/api',
    'https://meting.2333332.xyz/api'
  ];
  // ====================================

  const STORAGE_KEY = 'lw_music_player_state';

  let PLAYLIST = [];
  let currentApiIndex = 0;

  // 状态恢复
  function loadState() {
    try {
      const saved = localStorage.getItem(STORAGE_KEY);
      if (saved) return JSON.parse(saved);
    } catch (e) {}
    return { volume: 0.7, currentIndex: 0 };
  }

  function saveState(state) {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(state));
    } catch (e) {}
  }

  const state = loadState();

  // HTML 模板
  const html = `
    <button class="mp-toggle" id="mpToggle" aria-label="音乐播放器" title="音乐播放器">
      <i class="fas fa-music"></i>
    </button>
    <div class="mp-panel" id="mpPanel">
      <div class="mp-header">
        <button class="mp-btn mp-playlist-btn" id="mpToggleList" title="歌单" aria-label="歌单">
          <i class="fas fa-list"></i>
        </button>
      </div>
      <div class="mp-cover">
        <div class="mp-cover-img" id="mpCover"></div>
        <div class="mp-cover-info">
          <div class="mp-artist" id="mpArtist">加载中...</div>
          <div class="mp-song" id="mpSong">网易云音乐</div>
          <div class="mp-lyric" id="mpLyric">正在获取歌单</div>
        </div>
      </div>
      <div class="mp-progress">
        <span id="mpCurrentTime">00:00</span>
        <div class="mp-progress-bar" id="mpProgressBar">
          <div class="mp-progress-fill" id="mpProgressFill"></div>
        </div>
        <span id="mpDuration">00:00</span>
      </div>
      <div class="mp-controls">
        <button class="mp-btn mp-prev" id="mpPrev" title="上一首" aria-label="上一首">
          <i class="fas fa-step-backward"></i>
        </button>
        <button class="mp-btn mp-play" id="mpPlay" title="播放/暂停" aria-label="播放/暂停">
          <i class="fas fa-play" id="mpPlayIcon"></i>
        </button>
        <button class="mp-btn mp-next" id="mpNext" title="下一首" aria-label="下一首">
          <i class="fas fa-step-forward"></i>
        </button>
      </div>
      <div class="mp-volume">
        <i class="fas fa-volume-up mp-volume-icon" id="mpVolumeIcon"></i>
        <div class="mp-volume-slider" id="mpVolumeBar">
          <div class="mp-volume-fill" id="mpVolumeFill"></div>
        </div>
        <i class="fas fa-volume-down mp-volume-icon"></i>
      </div>
      <div class="mp-playlist" id="mpPlaylist">
        <div class="mp-playlist-header">
          <span id="mpPlaylistTitle">歌单 (加载中)</span>
          <span class="mp-toggle-list" id="mpToggleList2">收起</span>
        </div>
        <div id="mpPlaylistItems"></div>
      </div>
    </div>
  `;

  // 注入 DOM
  const container = document.createElement('div');
  container.id = 'music-player';
  container.innerHTML = html;
  document.body.appendChild(container);

  // 加载 FontAwesome
  if (!document.querySelector('link[href*="font-awesome"]') && !document.querySelector('link[href*="fontawesome"]')) {
    const fa = document.createElement('link');
    fa.rel = 'stylesheet';
    fa.href = 'https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.0/css/all.min.css';
    document.head.appendChild(fa);
  }

  // 元素引用
  const player = document.getElementById('music-player');
  const audio = new Audio();
  audio.preload = 'metadata';
  audio.volume = state.volume;

  const elToggle = document.getElementById('mpToggle');
  const elCover = document.getElementById('mpCover');
  const elArtist = document.getElementById('mpArtist');
  const elSong = document.getElementById('mpSong');
  const elLyric = document.getElementById('mpLyric');
  const elCurrentTime = document.getElementById('mpCurrentTime');
  const elDuration = document.getElementById('mpDuration');
  const elProgressBar = document.getElementById('mpProgressBar');
  const elProgressFill = document.getElementById('mpProgressFill');
  const elPlay = document.getElementById('mpPlay');
  const elPlayIcon = document.getElementById('mpPlayIcon');
  const elPrev = document.getElementById('mpPrev');
  const elNext = document.getElementById('mpNext');
  const elVolumeBar = document.getElementById('mpVolumeBar');
  const elVolumeFill = document.getElementById('mpVolumeFill');
  const elVolumeIcon = document.getElementById('mpVolumeIcon');
  const elPlaylist = document.getElementById('mpPlaylist');
  const elPlaylistItems = document.getElementById('mpPlaylistItems');
  const elToggleList = document.getElementById('mpToggleList');
  const elToggleList2 = document.getElementById('mpToggleList2');
  const elPlaylistTitle = document.getElementById('mpPlaylistTitle');

  // 初始化音量条
  elVolumeFill.style.width = (state.volume * 100) + '%';

  // 格式化时间
  function formatTime(sec) {
    if (!isFinite(sec) || sec < 0) return '00:00';
    const m = Math.floor(sec / 60);
    const s = Math.floor(sec % 60);
    return String(m).padStart(2, '0') + ':' + String(s).padStart(2, '0');
  }

  // 渲染歌单
  function renderPlaylist() {
    if (PLAYLIST.length === 0) {
      elPlaylistItems.innerHTML = '<div style="padding:16px 4px;color:#888;font-size:12px;text-align:center;">歌单加载中...</div>';
      return;
    }
    elPlaylistItems.innerHTML = PLAYLIST.map((item, idx) => `
      <div class="mp-playlist-item ${idx === state.currentIndex ? 'active' : ''}" data-idx="${idx}">
        <div class="mp-pl-index">${idx === state.currentIndex && !audio.paused ? '<i class="fas fa-volume-up"></i>' : (idx + 1)}</div>
        <div class="mp-pl-info">
          <div class="mp-pl-song">${escapeHtml(item.title)}</div>
          <div class="mp-pl-artist">${escapeHtml(item.artist)}</div>
        </div>
      </div>
    `).join('');

    elPlaylistItems.querySelectorAll('.mp-playlist-item').forEach(item => {
      item.addEventListener('click', () => {
        const idx = parseInt(item.dataset.idx, 10);
        if (idx !== state.currentIndex) {
          state.currentIndex = idx;
          saveState(state);
          loadSong(idx, true);
        }
      });
    });
  }

  function escapeHtml(str) {
    if (!str) return '';
    return String(str).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
  }

  // 加载歌曲
  function loadSong(idx, autoPlay) {
    const song = PLAYLIST[idx];
    if (!song) return;

    elArtist.textContent = song.artist;
    elSong.textContent = song.title;
    elLyric.textContent = song.album || '网易云音乐';

    if (song.cover) {
      elCover.style.backgroundImage = `url('${song.cover}')`;
    } else {
      elCover.style.backgroundImage = '';
      elCover.style.background = 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)';
    }

    if (song.src) {
      audio.src = song.src;
    } else if (song.id) {
      fetchSongUrl(song.id).then(url => {
        if (url && state.currentIndex === idx) {
          song.src = url;
          audio.src = url;
          if (autoPlay) audio.play().catch(() => updatePlayIcon(false));
        }
      });
    }

    renderPlaylist();
    if (autoPlay && song.src) audio.play().catch(() => updatePlayIcon(false));
  }

  // 更新播放图标
  function updatePlayIcon(playing) {
    elPlayIcon.className = playing ? 'fas fa-pause' : 'fas fa-play';
    if (playing) player.classList.add('playing');
    else player.classList.remove('playing');
  }

  // 切换播放/暂停
  function togglePlay() {
    if (PLAYLIST.length === 0) return;
    const cur = PLAYLIST[state.currentIndex];
    if (!cur) return;
    if (!cur.src && cur.id) {
      fetchSongUrl(cur.id).then(url => {
        if (url) { cur.src = url; audio.src = url; audio.play().catch(() => updatePlayIcon(false)); }
      });
      return;
    }
    if (audio.paused) audio.play(); else audio.pause();
  }

  // 展开/折叠
  function expand() { player.classList.add('expanded'); }
  function collapse() { player.classList.remove('expanded'); }
  function toggle() { player.classList.toggle('expanded'); }

  // 切换歌单
  function togglePlaylist() {
    elPlaylist.classList.toggle('open');
    elToggleList2.textContent = elPlaylist.classList.contains('open') ? '收起' : '展开';
  }

  // 事件绑定
  elToggle.addEventListener('click', toggle);
  elToggleList.addEventListener('click', togglePlaylist);
  elToggleList2.addEventListener('click', togglePlaylist);
  elPlay.addEventListener('click', togglePlay);
  elPrev.addEventListener('click', () => {
    if (PLAYLIST.length === 0) return;
    state.currentIndex = (state.currentIndex - 1 + PLAYLIST.length) % PLAYLIST.length;
    saveState(state); loadSong(state.currentIndex, true);
  });
  elNext.addEventListener('click', () => {
    if (PLAYLIST.length === 0) return;
    state.currentIndex = (state.currentIndex + 1) % PLAYLIST.length;
    saveState(state); loadSong(state.currentIndex, true);
  });

  // 进度条点击
  elProgressBar.addEventListener('click', (e) => {
    if (!audio.duration) return;
    const rect = elProgressBar.getBoundingClientRect();
    audio.currentTime = ((e.clientX - rect.left) / rect.width) * audio.duration;
  });

  // 音量
  function updateVolumeBar(ratio) {
    ratio = Math.max(0, Math.min(1, ratio));
    const percent = (ratio * 100) + '%';
    elVolumeFill.style.width = percent;
    elVolumeBar.style.setProperty('--volume', percent);
    audio.volume = ratio; state.volume = ratio; saveState(state);
    elVolumeIcon.className = ratio === 0 ? 'fas fa-volume-mute' : (ratio < 0.5 ? 'fas fa-volume-down' : 'fas fa-volume-up');
  }
  updateVolumeBar(state.volume);

  elVolumeBar.addEventListener('click', (e) => {
    const rect = elVolumeBar.getBoundingClientRect();
    updateVolumeBar((e.clientX - rect.left) / rect.width);
  });
  elVolumeIcon.addEventListener('click', () => {
    if (audio.volume > 0) {
      state.lastVolume = audio.volume;
      updateVolumeBar(0);
    } else {
      updateVolumeBar(state.lastVolume || 0.7);
    }
  });

  // 音频事件
  audio.addEventListener('play', () => updatePlayIcon(true));
  audio.addEventListener('pause', () => updatePlayIcon(false));
  audio.addEventListener('ended', () => {
    if (PLAYLIST.length === 0) return;
    state.currentIndex = (state.currentIndex + 1) % PLAYLIST.length;
    saveState(state); loadSong(state.currentIndex, true);
  });
  audio.addEventListener('timeupdate', () => {
    elCurrentTime.textContent = formatTime(audio.currentTime);
    if (audio.duration) elProgressFill.style.width = (audio.currentTime / audio.duration * 100) + '%';
  });
  audio.addEventListener('loadedmetadata', () => { elDuration.textContent = formatTime(audio.duration); });
  audio.addEventListener('error', () => {
    console.warn('音频加载失败:', audio.src);
    if (PLAYLIST[state.currentIndex]) elSong.textContent = '加载失败: ' + PLAYLIST[state.currentIndex].title;
  });

  // ============ Meting API 集成 ============

  // 尝试多个 API，直到有一个成功
  async function tryFetch(url) {
    for (let i = 0; i < METING_APIS.length; i++) {
      const apiUrl = METING_APIS[i] + url;
      try {
        const resp = await fetch(apiUrl, { method: 'GET', mode: 'cors' });
        if (resp.ok) {
          const data = await resp.json();
          if (data && (Array.isArray(data) || data.data || data.url)) {
            currentApiIndex = i;
            console.log('[MusicPlayer] API 成功:', METING_APIS[i]);
            return data;
          }
        }
      } catch (e) {
        console.warn('[MusicPlayer] API 失败:', METING_APIS[i], e.message);
      }
    }
    return null;
  }

  // 获取歌单
  async function fetchPlaylist(id) {
    const data = await tryFetch(`?server=netease&type=playlist&id=${encodeURIComponent(id)}&limit=999`);
    if (!data) return null;
    // Meting API 返回数组
    if (Array.isArray(data)) return data;
    return null;
  }

  // 获取歌曲 URL
  async function fetchSongUrl(songId) {
    const data = await tryFetch(`?server=netease&type=url&id=${encodeURIComponent(songId)}`);
    if (!data) return null;
    if (typeof data === 'string') return data;
    if (data && data.url) return data.url;
    return null;
  }

  // 初始化
  async function initPlaylist() {
    elPlaylistTitle.textContent = '歌单 (加载中)';
    elArtist.textContent = '加载中...';
    elSong.textContent = '正在获取歌单...';
    elLyric.textContent = '请稍候';

    const data = await fetchPlaylist(NETEASE_PLAYLIST_ID);

    if (!data || data.length === 0) {
      elSong.textContent = '歌单加载失败';
      elLyric.textContent = '请检查歌单 ID 或网络';
      elPlaylistTitle.textContent = '歌单 (加载失败)';
      elPlaylistItems.innerHTML = '<div style="padding:16px 4px;color:#f5576c;font-size:12px;text-align:center;">歌单加载失败<br>公开 API 可能暂时不可用<br>请稍后重试或更换歌单 ID</div>';
      return;
    }

    PLAYLIST = data.map(t => ({
      id: t.id || 0,
      title: t.name || t.title || '未知歌曲',
      artist: t.artist || t.author || '未知艺术家',
      album: t.album || '',
      cover: t.cover || t.pic || '',
      src: t.url || null,
      duration: 0
    }));

    elPlaylistTitle.textContent = `歌单 (${PLAYLIST.length})`;
    state.currentIndex = Math.min(state.currentIndex, PLAYLIST.length - 1);
    saveState(state);
    loadSong(state.currentIndex, false);
    renderPlaylist();
    console.log('[MusicPlayer] 歌单加载完成，共', PLAYLIST.length, '首');
  }

  initPlaylist();

  window.LWMusicPlayer = {
    play: () => elPlay.click(),
    next: () => elNext.click(),
    prev: () => elPrev.click(),
    expand, collapse,
    setPlaylistId: async (id) => { state.currentIndex = 0; saveState(state); await initPlaylist(); }
  };
})();
