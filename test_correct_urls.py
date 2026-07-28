import requests
import re
import json

session = requests.Session()
session.headers['User-Agent'] = 'Mozilla/5.0'

# Original URLs (these may 404)
ORIG_URLS = [
    "http://localhost:4000/2024/08/21/bootstrap/document/08-%E9%A1%B9%E8%81%98%E7%BD%91%E4%B8%AD%E7%9A%84%E7%AE%80%E5%8E%86%E6%A8%A1%E6%9D%BF/",
    "http://localhost:4000/2024/08/21/bootstrap/document/09-%E4%BB%BF%E6%98%9F%E5%B7%B4%E5%85%8B%E7%BD%91%E7%AB%99/",
    "http://localhost:4000/2024/08/21/bootstrap/document/10-%E7%9B%B8%E5%86%8C%E7%B1%BB%E5%8D%9A%E5%AE%A2%E9%A1%B9%E7%9B%AE/",
    "http://localhost:4000/2024/08/21/bootstrap/document/11-%E8%AE%BE%E8%AE%A1%E6%B5%81%E8%A1%8C%E4%BC%81%E4%B8%9A%E7%BD%91%E7%AB%99/",
    "http://localhost:4000/2024/08/20/bootstrap/document/12-Web%E8%AE%BE%E8%AE%A1%E4%B8%8E%E5%AE%9A%E5%88%B6%E7%BD%91%E7%AB%99/",
    "http://localhost:4000/2024/08/20/bootstrap/document/13-%E5%BC%80%E5%8F%91%E7%A5%9E%E5%BD%B1%E8%A7%86%E9%A2%91%E7%BD%91%E7%AB%99/",
]

# Get all category pages to find correct URLs for items 10, 11, 12, 13 (10-13 may be on page 2)
all_bootstrap_links = []
for pg in [1, 2]:
    cat_url = f"http://localhost:4000/categories/bootstrap/page/{pg}/" if pg > 1 else "http://localhost:4000/categories/bootstrap/"
    try:
        r = session.get(cat_url, timeout=15)
        print(f"Category page {pg}: {r.status_code}, len={len(r.text)}")
        if r.status_code == 200:
            all_links = re.findall(r'<a[^>]+href="([^"]+)"[^>]*>(.*?)</a>', r.text, re.S)
            for h, t in all_links:
                t_clean = re.sub(r'<[^>]+>', '', t).strip()
                if '/bootstrap/' in h and '/page/' not in h and h != '/categories/bootstrap/' and h != '/tags/bootstrap/':
                    all_bootstrap_links.append((h, t_clean))
    except Exception as e:
        print(f"Error on page {pg}: {e}")

# Find specific case links (08-13)
case_links = []
for h, t in all_bootstrap_links:
    # Look for "08-" or "09-" or "10-" or "11-" or "12-" or "13-" prefix
    m = re.search(r'/0(\d+)-[^/]+/$', h)
    if m:
        num = int(m.group(1))
        if 8 <= num <= 13:
            case_links.append((num, h, t))

# Sort by number
case_links.sort(key=lambda x: x[0])
print("\n=== Found case links ===")
for num, h, t in case_links:
    print(f"  {num}: {h} | {t}")

# Sections to look for
SECTIONS = ["案例概述", "涉及知识点", "实现步骤", "完整代码", "关键技术解析"]

# Visit each correct URL and check sections
results = []
for num, href, link_text in case_links:
    full_url = "http://localhost:4000" + href
    rec = {
        "case_num": num,
        "original_link": link_text,
        "correct_url": full_url,
        "status": None,
        "title": None,
        "h1": None,
        "sections": {},
    }
    try:
        r = session.get(full_url, timeout=15)
        rec["status"] = r.status_code
        html = r.text
        # Title
        tmatch = re.search(r'<title>(.*?)</title>', html, re.S)
        if tmatch:
            rec["title"] = tmatch.group(1).strip()
        # H1
        h1s = re.findall(r'<h1[^>]*>(.*?)</h1>', html, re.S)
        if h1s:
            rec["h1"] = re.sub(r'<[^>]+>', '', h1s[0]).strip()
        # Sections
        text = re.sub(r'<[^>]+>', ' ', html)
        text = re.sub(r'\s+', ' ', text)
        for sec in SECTIONS:
            rec["sections"][sec] = sec in text
        # Also check h2 / h3 section headers
        h2s = re.findall(r'<h2[^>]*>(.*?)</h2>', html, re.S)
        h3s = re.findall(r'<h3[^>]*>(.*?)</h3>', html, re.S)
        rec["h2_headers"] = [re.sub(r'<[^>]+>', '', h).strip() for h in h2s]
        rec["h3_headers"] = [re.sub(r'<[^>]+>', '', h).strip() for h in h3s]
    except Exception as e:
        rec["error"] = str(e)
    results.append(rec)

print("\n\n===== FINAL PAGE RESULTS =====")
print(json.dumps(results, ensure_ascii=False, indent=2))

# Save
with open('e:/softeem/LW/blog/final_results.json', 'w', encoding='utf-8') as f:
    json.dump(results, f, ensure_ascii=False, indent=2)
