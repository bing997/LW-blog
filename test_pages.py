from playwright.sync_api import sync_playwright
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

CATEGORY_PAGE = "http://localhost:4000/categories/bootstrap/"

results = []

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    context = browser.new_context()
    page = context.new_page()

    for url, expected_title in URLS:
        rec = {
            "url": url,
            "expected_title": expected_title,
            "status": None,
            "http_code": None,
            "actual_title": None,
            "is_404": False,
            "sections_found": {},
            "final_url": None,
        }
        try:
            response = page.goto(url, wait_until="networkidle", timeout=20000)
            rec["http_code"] = response.status if response else None
            rec["final_url"] = page.url
            content = page.content()
            rec["is_404"] = ("404" in page.title() or "Not Found" in page.title() or "Page not found" in content[:5000])
            rec["actual_title"] = page.title()
            # Get the article heading if exists
            heading_loc = page.locator("article h1, .post-title, h1.post-title, header h1, h1").first
            if heading_loc.count() > 0:
                rec["article_heading"] = heading_loc.text_content().strip()
            else:
                rec["article_heading"] = None

            # Check for each section keyword
            body_text = page.inner_text("body") if page.locator("body").count() else ""
            for sec in SECTIONS:
                rec["sections_found"][sec] = sec in body_text
        except Exception as e:
            rec["error"] = str(e)
        results.append(rec)

    # Handle 404 by visiting category page
    need_category = any(r.get("is_404") or r.get("http_code") == 404 for r in results)
    if need_category:
        try:
            page.goto(CATEGORY_PAGE, wait_until="networkidle", timeout=20000)
            cat_html = page.content()
            rec["category_page_html"] = cat_html[:3000]
            # Find all bootstrap category links
            links = page.eval_on_selector_all(
                "a[href*='/bootstrap/']",
                "els => els.map(e => ({href: e.getAttribute('href'), text: e.textContent.trim()}))"
            )
            rec["bootstrap_links"] = links
        except Exception as e:
            rec["category_error"] = str(e)

    print(json.dumps(results, ensure_ascii=False, indent=2))
    browser.close()
