$ErrorActionPreference = 'Continue'
$urls = @(
    'http://localhost:4000/2024/08/21/bootstrap/document/08-项目案例：招聘网中的简历模板/',
    'http://localhost:4000/2024/08/21/bootstrap/document/09-项目案例：仿星巴克网站/',
    'http://localhost:4000/2024/08/21/bootstrap/document/10-项目案例：相册类博客项目/',
    'http://localhost:4000/2024/08/21/bootstrap/document/11-项目案例：设计流行企业网站/',
    'http://localhost:4000/2024/08/20/bootstrap/document/12-Web设计与定制网站/',
    'http://localhost:4000/2024/08/20/bootstrap/document/13-项目案例：开发神影视频网站/'
)
foreach ($u in $urls) {
    Write-Host '===' $u '==='
    try {
        $resp = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 10
        Write-Host 'Status:' $resp.StatusCode
        Write-Host 'FinalURL:' $resp.BaseResponse.RequestMessage.RequestUri
        $html = $resp.Content
        if ($html -match '<title>(.*?)</title>') {
            Write-Host 'Title:' $matches[1]
        }
        foreach ($s in @([char]0x6848,[char]0x4F8B,[char]0x6982,[char]0x8FF0)) { }
    } catch {
        Write-Host 'ERROR:' $_.Exception.Message
    }
    Write-Host ''
}