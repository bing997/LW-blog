import requests
import re
import json

URLS = [
    ("http://localhost:4000/2024/08/21/bootstrap/document/08-%E9%A1%B9%E8%81%98%E7%BD%91%E4%B8%AD%E7%9A%84%E7%AE%80%E5%8E%86%E6%A8%A1%E6%9D%BF/", "08-项目案例：招聘网中的简历模板"),
    ("http://localhost:4000/2024/08/21/bootstrap/document/09-%E4%BB%BF%E6%98%9F%E5%B7%B4%E5%85%8B%E7%BD%91%E7%AB%99/", "09-项目案例：仿星巴克网站"),
    ("http://localhost:4000/2024/08/21/bootstrap/document/10-%E7%9B%B8%E5%86%8C%E7%B1%BB%E5%8D%9A%E5%AE%A2%E9%A1%B9%E7%9B%AE/", "10-项目案例：相册类博客项目"),
    ("http://localhost:4000/2024/08/21/bootstrap/document/11-%E8%AE%BE%E8%AE%A1%E6%B5%81%E8%A1%8C%E4%BC%81%E4%B8%9A%E7%BD%91%E7%AB%99/", "11-项目案例：设计流行企业网站"),
    ("http://localhost:4000/2024/08/20/bootstrap/document/12-Web%E8%AE%BE%E8%AE%A1%E4%B8%8E%E5%AE%9A%E5%88%B6%E7%BD%91%E7%AB%99/", "12-项目案例：Web设计与定制网站"),
    ("http://localhost:4000/2024/08/20/bootstrap/document/13-%E5%BC%80%E5%8F%91%E7%A5%9E%E5%BD%B1%E8%A7%86%E9%A2%91%E7%BD%91%E7%AB%99/", "13-项目案例：开发神影视频网站"),
]

SECTIONS = ["案例概述", "涉及知识点", "实现步骤", "完整代码", "关键技术解析"]

results = []
session = requests.Session()
session.headers['User-Agent'] = 'Mozilla/5.0'

for url, expected_title in URLS:
    rec = {
        "url": url,
        "expected_title": expected_title,
        "status_code": None,
        "is_404": False,
        "title": None,
        "h1": None,
        "sections": {},
        "error": None,
    }
    try:
        resp = session.get(url, timeout=15, allow_redirects=True)
        rec["status_code"] = resp.status_code
        rec["final_url"] = resp.url
        html = resp.text
        # Detect 404
        if resp.status_code == 404:
            rec["is_404"] = True
        else:
            # Check title
            tmatch = re.search(r'<title>(.*?)</title>', html, re.S)
            if tmatch:
                rec["title"] = tmatch.group(1).strip()
            # Check h1
            h1matches = re.findall(r'<h1[^>]*>(.*?)</h1>', html, re.S)
            if h1matches:
                rec["h1"] = re.sub(r'<[^>]+>', '', h1matches[0]).strip()
            # Check for 404 keywords
            if 'Page not found' in html or '抱歉，页面无法找到' in html or '404' in rec.get('title',''):
                rec['is_404'] = True
            # Check sections (strip HTML tags to look at text)
            text = re.sub(r'<[^>]+>', ' ', html)
            text = re.sub(r'\s+', ' ', text)
            for sec in SECTIONS:
                rec["sections"][sec] = sec in text
    except Exception as e:
        rec["error"] = str(e)
    results.append(rec)
    print(f"[{rec['status_code']}] {url} -> is_404={rec['is_404']}, h1={rec.get('h1')}")

# If any 404, fetch category page
any_404 = any(r['is_404'] for r in results)
category_data = None
if any_404:
    try:
        cat_resp = session.get("http://localhost:4000/categories/bootstrap/", timeout=15)
        cat_html = cat_resp.text
        # Find all bootstrap-related links
        all_links = re.findall(r'<a[^>]+href="([^"]+)"[^>]*>(.*?)</a>', cat_html, re.S)
        bootstrap_links = [(h, re.sub(r'<[^>]+>', '', t).strip()) for h, t in all_links if '/bootstrap/' in h]
        category_data = {
            "status": cat_resp.status_code,
            "count": len(bootstrap_links),
            "links": bootstrap_links
        }
        print(f"\n[Category page] Status: {cat_resp.status_code}, {len(bootstrap_links)} bootstrap links")
        for h, t in bootstrap_links:
            print(f"  -> {h} | {t}")
    except Exception as e:
        category_data = {"error": str(e)}

# Save results
with open('e:/softeem/LW/blog/test_results.json', 'w', encoding='utf-8') as f:
    json.dump({"pages": results, "category": category_data}, f, ensure_ascii=False, indent=2)

print("\n\n===== FINAL RESULTS =====")
print(json.dumps({"pages": results, "category": category_data}, ensure_ascii=False, indent=2))
