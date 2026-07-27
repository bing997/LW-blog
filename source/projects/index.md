---
title: 毕设项目库
date: 2026-05-04 00:00:00
type: projects
description: 软件工程毕业设计项目库
---

<style>
.projects-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.projects-header {
  text-align: center;
  margin-bottom: 30px;
}

.projects-header h1 {
  font-size: 2.5em;
  margin-bottom: 10px;
  color: var(--font-color);
}

.projects-header p {
  color: #666;
  font-size: 1.1em;
}

.tabs {
  display: flex;
  gap: 10px;
  margin-bottom: 25px;
  flex-wrap: wrap;
  justify-content: center;
  border-bottom: 2px solid var(--border-color);
  padding-bottom: 0;
}

.tab-btn {
  padding: 12px 24px;
  border: none;
  background: transparent;
  color: var(--font-color);
  cursor: pointer;
  font-size: 15px;
  transition: all 0.3s;
  border-bottom: 3px solid transparent;
  margin-bottom: -2px;
  opacity: 0.7;
}

.tab-btn:hover {
  opacity: 1;
  color: #49b1f5;
}

.tab-btn.active {
  opacity: 1;
  color: #49b1f5;
  border-bottom-color: #49b1f5;
  font-weight: 600;
}

.tab-count {
  display: inline-block;
  background: #e8f4fc;
  color: #49b1f5;
  padding: 2px 8px;
  border-radius: 10px;
  font-size: 12px;
  margin-left: 6px;
}

.search-box {
  margin-bottom: 20px;
  display: flex;
  gap: 15px;
  flex-wrap: wrap;
  justify-content: center;
}

.search-input {
  flex: 1;
  min-width: 280px;
  max-width: 500px;
  padding: 12px 20px;
  border: 2px solid #e0e0e0;
  border-radius: 25px;
  font-size: 16px;
  transition: border-color 0.3s;
  background: var(--card-bg);
  color: var(--font-color);
}

.search-input:focus {
  outline: none;
  border-color: #49b1f5;
}

.filter-group {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  justify-content: center;
  margin-bottom: 15px;
}

.filter-btn {
  padding: 8px 20px;
  border: 1px solid #ddd;
  border-radius: 20px;
  background: var(--card-bg);
  color: var(--font-color);
  cursor: pointer;
  transition: all 0.3s;
  font-size: 14px;
}

.filter-btn:hover,
.filter-btn.active {
  background: #49b1f5;
  color: white;
  border-color: #49b1f5;
}

.stats {
  text-align: center;
  margin-bottom: 20px;
  color: #888;
  font-size: 14px;
}

.projects-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 20px;
}

.project-card {
  background: var(--card-bg);
  border-radius: 12px;
  padding: 20px;
  transition: transform 0.3s, box-shadow 0.3s;
  border: 1px solid var(--border-color);
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.project-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
}

.project-card::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(90deg, #49b1f5, #67c23a);
  transform: scaleX(0);
  transition: transform 0.3s;
}

.project-card:hover::after {
  transform: scaleX(1);
}

.project-id {
  display: inline-block;
  background: #49b1f5;
  color: white;
  padding: 2px 10px;
  border-radius: 12px;
  font-size: 12px;
  margin-bottom: 10px;
}

.project-title {
  font-size: 1.05em;
  font-weight: 600;
  margin-bottom: 12px;
  color: var(--font-color);
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.project-tech {
  margin-bottom: 12px;
}

.tech-tag {
  display: inline-block;
  padding: 4px 10px;
  background: #e8f4fc;
  color: #49b1f5;
  border-radius: 4px;
  font-size: 12px;
  margin: 2px;
}

.project-meta {
  display: flex;
  gap: 15px;
  font-size: 13px;
  color: #888;
  margin-top: 10px;
  flex-wrap: wrap;
}

.project-meta span {
  display: flex;
  align-items: center;
  gap: 5px;
}

.project-meta i {
  width: 16px;
}

.no-results {
  text-align: center;
  padding: 60px 20px;
  color: #888;
}

.no-results i {
  font-size: 48px;
  margin-bottom: 20px;
}

.loading {
  text-align: center;
  padding: 60px;
  color: #888;
}

.modal-overlay {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.6);
  z-index: 1000;
  justify-content: center;
  align-items: center;
  backdrop-filter: blur(5px);
}

.modal-overlay.active {
  display: flex;
}

.modal {
  background: var(--card-bg);
  border-radius: 16px;
  max-width: 800px;
  width: 90%;
  max-height: 85vh;
  overflow: hidden;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  animation: modalFadeIn 0.3s ease;
}

@keyframes modalFadeIn {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 24px;
  border-bottom: 1px solid var(--border-color);
  background: linear-gradient(135deg, #49b1f5 0%, #36a3f7 100%);
  color: white;
}

.modal-header h2 {
  margin: 0;
  font-size: 1.4em;
  flex: 1;
}

.modal-close {
  background: rgba(255, 255, 255, 0.2);
  border: none;
  color: white;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  font-size: 20px;
  cursor: pointer;
  transition: background 0.3s;
}

.modal-close:hover {
  background: rgba(255, 255, 255, 0.3);
}

.modal-body {
  padding: 24px;
  overflow-y: auto;
  max-height: calc(85vh - 120px);
}

.modal-section {
  margin-bottom: 24px;
}

.modal-section:last-child {
  margin-bottom: 0;
}

.section-title {
  font-size: 1.1em;
  font-weight: 600;
  color: var(--font-color);
  margin-bottom: 12px;
  padding-left: 12px;
  border-left: 4px solid #49b1f5;
}

.detail-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 16px;
}

.detail-item {
  background: rgba(73, 177, 245, 0.05);
  padding: 14px 18px;
  border-radius: 8px;
}

.detail-label {
  font-size: 12px;
  color: #888;
  margin-bottom: 4px;
}

.detail-value {
  font-size: 14px;
  color: var(--font-color);
  font-weight: 500;
}

.tech-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.tech-item {
  background: #e8f4fc;
  color: #49b1f5;
  padding: 6px 14px;
  border-radius: 20px;
  font-size: 13px;
}

.gallery-section {
  margin-top: 16px;
}

.gallery-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 12px;
}

.gallery-item {
  aspect-ratio: 4/3;
  background: #f5f5f5;
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color: #aaa;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.3s;
  border: 1px dashed #ddd;
}

.gallery-item:hover {
  background: #e8f4fc;
  border-color: #49b1f5;
  color: #49b1f5;
}

.gallery-item i {
  font-size: 32px;
  margin-bottom: 8px;
}

.video-container {
  background: #000;
  border-radius: 8px;
  overflow: hidden;
  aspect-ratio: 16/9;
  display: flex;
  justify-content: center;
  align-items: center;
  color: #666;
}

.project-desc {
  line-height: 1.8;
  color: var(--font-color);
  font-size: 14px;
}

.feature-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 12px;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px 16px;
  background: rgba(103, 194, 58, 0.08);
  border-radius: 8px;
  border-left: 3px solid #67c23a;
  font-size: 14px;
  color: var(--font-color);
}

.feature-item i {
  color: #67c23a;
  font-size: 14px;
  flex-shrink: 0;
}

@media (max-width: 768px) {
  .projects-grid {
    grid-template-columns: 1fr;
  }
  .search-box {
    flex-direction: column;
  }
  .search-input {
    max-width: 100%;
  }
  .tab-btn {
    padding: 10px 16px;
    font-size: 14px;
  }
  .modal {
    width: 95%;
    max-height: 90vh;
  }
  .modal-body {
    padding: 16px;
  }
}
</style>

<div class="projects-container">
  <div class="projects-header">
    <h1>毕设项目库</h1>
    <p>收集整理软件工程专业优秀毕业设计项目，展示项目成果与技术栈</p>
  </div>

  <div class="tabs" id="tabs">
  </div>

  <div class="search-box">
    <input type="text" class="search-input" id="searchInput" placeholder="搜索项目名称或技术栈...">
  </div>

  <div class="filter-group" id="filterGroup">
  </div>

  <div class="stats" id="stats">共加载 <strong>0</strong> 个项目</div>

  <div class="projects-grid" id="projectsGrid">
    <div class="loading">
      <p>正在加载项目数据...</p>
    </div>
  </div>
</div>

<div class="modal-overlay" id="modalOverlay">{% raw %}
  <div class="modal">
    <div class="modal-header">
      <h2 id="modalTitle">项目详情</h2>
      <button class="modal-close" id="modalClose" aria-label="关闭">×</button>
    </div>
    <div class="modal-body">
      <div class="detail-grid">
        <div class="detail-item">
          <div class="detail-label">项目编号</div>
          <div class="detail-value" id="modalId">-</div>
        </div>
        <div class="detail-item">
          <div class="detail-label">项目类型</div>
          <div class="detail-value" id="modalType">-</div>
        </div>
        <div class="detail-item">
          <div class="detail-label">业务领域</div>
          <div class="detail-value" id="modalDomain">-</div>
        </div>
        <div class="detail-item">
          <div class="detail-label">所属方向</div>
          <div class="detail-value" id="modalTab">-</div>
        </div>
      </div>

      <div class="modal-section">
        <div class="section-title">核心技术栈</div>
        <div class="tech-list" id="modalTech">
        </div>
      </div>

      <div class="modal-section">
        <div class="section-title">项目简介</div>
        <div class="project-desc" id="modalDesc">
          本项目基于上述技术栈开发，实现了完整的业务功能，具有良好的可扩展性和维护性。系统采用前后端分离架构，前端负责数据展示和用户交互，后端提供RESTful API服务。
        </div>
      </div>

      <div class="modal-section">
        <div class="section-title">项目功能</div>
        <div class="feature-list" id="modalFeatures">
        </div>
      </div>

      <div class="modal-section">
        <div class="section-title">项目截图</div>
        <div class="gallery-grid" id="modalGallery">
          <div class="gallery-item">
            <i class="fas fa-image"></i>
            <span>暂无截图</span>
          </div>
        </div>
      </div>

      <div class="modal-section">
        <div class="section-title">运行演示</div>
        <div class="video-container" id="modalVideo">
          <div style="text-align: center;">
            <i class="fas fa-video" style="font-size: 48px; margin-bottom: 10px;"></i>
            <p>暂无演示视频</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>{% endraw %}

<script>{% raw %}
let allData = {};
let currentTab = '';
let currentFilter = 'all';
let currentSearch = '';

async function loadProjects() {
  try {
    const basePath = window.location.pathname.startsWith('/LW-blog/') ? '/LW-blog' : '';
    const response = await fetch(`${basePath}/projects_all.json`);
    if (!response.ok) throw new Error('Failed to load');
    allData = await response.json();
    initTabs();
    renderProjects();
    initModal();
  } catch (error) {
    console.error('Error loading projects:', error);
    document.getElementById('projectsGrid').innerHTML = '<div class="no-results"><i class="fas fa-exclamation-triangle"></i><p>加载失败，请稍后重试</p></div>';
  }
}

function initTabs() {
  const tabs = Object.keys(allData);
  const tabsContainer = document.getElementById('tabs');
  tabsContainer.innerHTML = tabs.map((tab, index) => `
    <button class="tab-btn ${index === 0 ? 'active' : ''}" data-tab="${tab}">
      ${tab}
      <span class="tab-count">${allData[tab].length}</span>
    </button>
  `).join('');
  
  currentTab = tabs[0];
  
  tabsContainer.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      tabsContainer.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      currentTab = btn.dataset.tab;
      currentFilter = 'all';
      initFilters();
      renderProjects();
    });
  });
  
  initFilters();
}

function initFilters() {
  const projects = allData[currentTab] || [];
  const types = [...new Set(projects.map(p => p['项目类型']).filter(t => t))];
  const filterGroup = document.getElementById('filterGroup');
  
  filterGroup.innerHTML = `
    <button class="filter-btn active" data-filter="all">全部</button>
    ${types.map(t => `<button class="filter-btn" data-filter="${t}">${t}</button>`).join('')}
  `;
  
  filterGroup.querySelectorAll('.filter-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      filterGroup.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      currentFilter = btn.dataset.filter;
      renderProjects();
    });
  });
}

function getTechTags(tech) {
  if (!tech) return '';
  const tags = tech.split(/[+，、/]/).filter(t => t.trim());
  return tags.slice(0, 5).map(tag => `<span class="tech-tag">${tag.trim()}</span>`).join('');
}

function renderProjects() {
  const grid = document.getElementById('projectsGrid');
  let projects = allData[currentTab] || [];
  
  let filtered = projects;
  
  if (currentFilter !== 'all') {
    filtered = filtered.filter(p => p['项目类型'] === currentFilter);
  }
  
  if (currentSearch) {
    const search = currentSearch.toLowerCase();
    filtered = filtered.filter(p =>
      (p['论文题目'] && p['论文题目'].toLowerCase().includes(search)) ||
      (p['技术栈/核心技术'] && p['技术栈/核心技术'].toLowerCase().includes(search)) ||
      (p['业务领域'] && p['业务领域'].toLowerCase().includes(search))
    );
  }
  
  if (filtered.length === 0) {
    grid.innerHTML = `
      <div class="no-results" style="grid-column: 1/-1;">
        <i class="fas fa-search"></i>
        <p>未找到匹配的项目</p>
      </div>
    `;
    document.getElementById('stats').innerHTML = `共 <strong>${projects.length}</strong> 个项目`;
    return;
  }
  
  grid.innerHTML = filtered.map((p, i) => `
    <div class="project-card" data-index="${i}">
      <span class="project-id">#${p['序号'] || i + 1}</span>
      <div class="project-title" title="${p['论文题目'] || ''}">${p['论文题目'] || '未命名项目'}</div>
      <div class="project-tech">${getTechTags(p['技术栈/核心技术'])}</div>
      <div class="project-meta">
        ${p['项目类型'] ? `<span><i class="fas fa-laptop"></i> ${p['项目类型']}</span>` : ''}
        ${p['业务领域'] ? `<span><i class="fas fa-folder"></i> ${p['业务领域']}</span>` : ''}
      </div>
    </div>
  `).join('');
  
  grid.querySelectorAll('.project-card').forEach(card => {
    card.addEventListener('click', () => {
      const index = parseInt(card.dataset.index);
      showProjectDetail(filtered[index]);
    });
  });
  
  document.getElementById('stats').innerHTML = `共 <strong>${projects.length}</strong> 个项目${currentFilter !== 'all' || currentSearch ? `（筛选 <strong>${filtered.length}</strong> 个）` : ''}`;
}

function showProjectDetail(project) {
  document.getElementById('modalTitle').textContent = project['论文题目'] || '项目详情';
  document.getElementById('modalId').textContent = '#' + (project['序号'] || '未知');
  document.getElementById('modalType').textContent = project['项目类型'] || '-';
  document.getElementById('modalDomain').textContent = project['业务领域'] || '-';
  document.getElementById('modalTab').textContent = currentTab;
  
  const tech = project['技术栈/核心技术'] || '';
  const techTags = tech.split(/[+，、/]/).filter(t => t.trim());
  document.getElementById('modalTech').innerHTML = techTags.length > 0 
    ? techTags.map(tag => `<span class="tech-item">${tag.trim()}</span>`).join('')
    : '<span style="color:#888;">暂无技术栈信息</span>';
  
  const domain = project['业务领域'] || '';
  const type = project['项目类型'] || '';
  const desc = generateDescription(project['论文题目'] || '', domain, type);
  document.getElementById('modalDesc').textContent = desc;
  
  const features = generateFeatures(project['论文题目'] || '', domain, type);
  document.getElementById('modalFeatures').innerHTML = features.map(f => `
    <div class="feature-item">
      <i class="fas fa-check-circle"></i>
      <span>${f}</span>
    </div>
  `).join('');
  
  document.getElementById('modalOverlay').classList.add('active');
  document.body.style.overflow = 'hidden';
}

function generateDescription(title, domain, type) {
  const descMap = {
    '政务管理': '系统面向政府部门和政务服务场景，实现数据可视化、业务流程管理、在线审批等核心功能，提升政务服务效率和透明度。',
    '医疗健康': '系统专注于医疗健康领域，提供在线问诊、健康档案管理、预约挂号、慢病管理等功能，助力智慧医疗建设。',
    '养老': '针对养老服务场景，提供老人健康监测、服务预约、志愿者管理等功能，构建智慧养老服务体系。',
    '校园/教育': '面向高校和教育机构，实现学生管理、课程管理、成绩管理、实习管理等功能，提升教育信息化水平。',
    '电商': '基于电商业务模式，实现商品管理、订单处理、用户管理、支付集成等核心功能，构建完整的在线购物平台。',
    '企业管理': '为企业提供人力资源管理、资产管理、办公自动化等功能，优化企业内部管理流程。',
    'AI应用': '集成人工智能技术，实现智能推荐、数据分析、图像识别等智能化功能，提升系统智能化水平。',
    '微服务系统': '基于微服务架构设计，实现服务拆分、服务注册发现、API网关、分布式事务等核心能力，支撑高可用、高并发场景。'
  };
  
  let baseDesc = descMap[domain] || descMap[type] || '本项目基于上述技术栈开发，实现了完整的业务功能，具有良好的可扩展性和维护性。';
  
  if (title.includes('可视化') || title.includes('大屏')) {
    baseDesc = '系统集成数据可视化组件，实现数据大屏展示、实时数据监控、多维度数据分析等功能，为决策提供数据支撑。' + baseDesc;
  }
  if (title.includes('小程序')) {
    baseDesc = '基于微信小程序平台开发，实现轻量化移动端访问，提供便捷的用户体验和跨平台能力。' + baseDesc;
  }
  if (title.includes('SpringCloud') || title.includes('微服务')) {
    baseDesc = '采用微服务架构设计，支持服务独立部署、弹性伸缩、服务治理等特性，适用于中大型企业级应用场景。' + baseDesc;
  }
  
  return baseDesc;
}

function generateFeatures(title, domain, type) {
  const features = [];
  
  // 基础功能（所有系统都有）
  features.push('用户登录与权限管理');
  features.push('数据增删改查管理');
  
  // 根据业务领域
  const domainFeatures = {
    '政务管理': ['政务信息发布', '在线审批流程', '数据统计报表', '电子档案管理'],
    '医疗健康': ['患者信息管理', '在线预约挂号', '健康档案管理', '医嘱管理系统'],
    '养老': ['老人健康监测', '服务预约管理', '志愿者调度', '紧急呼叫系统'],
    '校园/教育': ['学生信息管理', '课程安排管理', '成绩录入查询', '实习就业跟踪'],
    '电商': ['商品分类展示', '购物车管理', '订单跟踪处理', '支付系统集成'],
    '企业管理': ['员工档案管理', '考勤绩效管理', '资产设备管理', '审批流程管理'],
    'AI应用': ['智能推荐算法', '数据可视化分析', '模型训练部署', '预测结果展示'],
    '微服务系统': ['服务注册发现', 'API网关管理', '分布式配置', '监控告警系统']
  };
  
  if (domainFeatures[domain]) {
    features.push(...domainFeatures[domain]);
  }
  
  // 根据标题关键词
  if (title.includes('可视化') || title.includes('大屏') || title.includes('ECharts')) {
    features.push('数据可视化大屏展示');
    features.push('实时数据监控');
  }
  if (title.includes('预约')) {
    features.push('在线预约排班');
    features.push('预约提醒通知');
  }
  if (title.includes('商城') || title.includes('购物')) {
    features.push('商品搜索筛选');
    features.push('订单物流跟踪');
  }
  if (title.includes('推荐')) {
    features.push('智能推荐算法');
    features.push('用户行为分析');
  }
  if (title.includes('微信小程序') || title.includes('小程序')) {
    features.push('移动端便捷访问');
    features.push('消息推送通知');
  }
  if (title.includes('SpringCloud') || title.includes('微服务')) {
    features.push('服务熔断降级');
    features.push('分布式事务');
  }
  if (title.includes('Vue') || title.includes('前后端分离')) {
    features.push('响应式界面设计');
    features.push('前后端API交互');
  }
  if (title.includes('SpringSecurity') || title.includes('JWT')) {
    features.push('JWT令牌认证');
    features.push('角色权限控制');
  }
  
  // 去重并返回
  return [...new Set(features)].slice(0, 8);
}

function initModal() {
  const overlay = document.getElementById('modalOverlay');
  const closeBtn = document.getElementById('modalClose');
  
  closeBtn.addEventListener('click', () => {
    overlay.classList.remove('active');
    document.body.style.overflow = '';
  });
  
  overlay.addEventListener('click', (e) => {
    if (e.target === overlay) {
      overlay.classList.remove('active');
      document.body.style.overflow = '';
    }
  });
  
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && overlay.classList.contains('active')) {
      overlay.classList.remove('active');
      document.body.style.overflow = '';
    }
  });
}

document.getElementById('searchInput').addEventListener('input', (e) => {
  currentSearch = e.target.value;
  renderProjects();
});

loadProjects();
</script>{% endraw %}
