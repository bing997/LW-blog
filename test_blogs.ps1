$ErrorActionPreference = "Continue"
$urls = @(
    "http://localhost:4000/2024/08/21/bootstrap/document/08-%E9%A1%B9%E8%81%98%E7%BD%91%E4%B8%AD%E7%9A%84%E7%AE%80%E5%8E%86%E6%A8%A1%E6%9D%BF/",
    "http://localhost:4000/2024/08/21/bootstrap/document/09-%E4%BB%BF%E6%98%9F%E5%B7%B4%E5%85%8B%E7%BD%91%E7%AB%99/",
    "http://localhost:4000/2024/08/21/bootstrap/document/10-%E7%9B%B8%E5%86%8C%E7%B1%BB%E5%8D%9A%E5%AE%A2%E9%A1%B9%E7%9B%AE/",
    "http://localhost:4000/2024/08/21/bootstrap/document/11-%E8%AE%BE%E8%AE%A1%E6%B5%81%E8%A1%8C%E4%BC%81%E4%B8%9A%E7%BD%91%E7%AB%99/",
    "http://localhost:4000/2024/08/20/bootstrap/document/12-Web%E8%AE%BE%E8%AE%A1%E4%B8%8E%E5%AE%9A%E5%88%B6%E7%BD%91%E7%AB%99/",
    "http://localhost:4000/2024/08/20/bootstrap/document/13-%E5%BC%80%E5%8F%91%E7%A5%9E%E5%BD%B1%E8%A7%86%E9%A2%91%E7%BD%91%E7%AB%99/"
)

foreach ($u in $urls) {
    Write-Host "=== $u ==="
    try {
        $resp = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 10
        Write-Host "Status: $($resp.StatusCode)"
        Write-Host "FinalURL: $($resp.BaseResponse.RequestMessage.RequestUri)"
        $html = $resp.Content
        # Get page title
        if ($html -match '<title>(.*?)</title>') {
            Write-Host "Title: $($matches[1])"
        }
        # Check for 404 indicators
        if ($html -match '404' -and $html -match 'Not Found|Page not found') {
            Write-Host "INDICATES 404"
        }
        # Check sections
        foreach ($s in @("案例概述", "涉及知识点", "实现步骤", "完整代码", "关键技术解析")) {
            if ($html.Contains($s)) {
                Write-Host "  [FOUND] $s"
            } else {
                Write-Host "  [MISS]  $s"
            }
        }
        # Get first h1
        if ($html -match '<h1[^>]*>(.*?)</h1>') {
            Write-Host "First H1: $($matches[1])"
        }
    } catch {
        Write-Host "ERROR: $($_.Exception.Message)"
        if ($_.Exception.Response) {
            $statusCode = $_.Exception.Response.StatusCode
            Write-Host "Status: $statusCode"
        }
    }
    Write-Host ""
}
