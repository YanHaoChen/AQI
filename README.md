#  AQI

此專案預期達成目標如下：

1. 取得全台目前[空氣品質, 抓取空氣品質指標、狀態、細懸浮微粒....](https://opendata.epa.gov.tw/Data/Contents/AQI/)

2. 資料取得之後存入 local 資料庫

3. 頁面 UI 提供資料列表瀏灠上列資料

4. 提供刪除某一筆資料的功能

5. 抓取[網頁](http://www.appledaily.com.tw/index/dailyquote/)的每日一句，一併顯示於畫面
6. 符合 MVC-n 架構

#### 資料存儲

* 使用 RealmSwift：將資料寫入 local 端。

#### 資料抓取

* 使用 URLSession：送出HTTP GET，取得空氣品質資訊及每日一句。
* 使用 SwiftSoup：解析 html。

> 再取得每日一句時，如沒有將 Header 的 User-Agent 設為電腦版的設定，Server 則會自動將此請求轉址，因此無法獲得預期的網頁。結果如下：
>
> ```javascript
> <script>window.location.href="/recommend/realtime/"</script>
> ```
>
> 從 Response 則可看出一些端倪(stop_mobi)：
>
> ```json
> {
>     "Content-Encoding" =     (
>         gzip
>     );
>     "Content-Length" =     (
>         73
>     );
>     "Content-Type" =     (
>         "text/html"
>     );
>     Date =     (
>         "Sat, 11 May 2019 03:15:07 GMT"
>     );
>     Server =     (
>         Apache
>     );
>     "Set-Cookie" =     (
>         "remote_addr=61.213.151.62; path=/; domain=tw.appledaily.com"
>     );
>     Vary =     (
>         "Accept-Encoding"
>     );
>     "stop_mobi" =     (
>         true
>     );
> } 
> ```

#### Uint Testing (with dependency injection)

* Normal：測試 Data 物件轉換功能 (轉成 JsonArray or String) 是否如預期。

* Network：測試更換GET參數後，結果是否如預期。

* Network：透過 Protocol 讓專案可以使用 MockURLSession 及 MockURLSessionDataTask，進一步測試網路運作是否如預期。

  

> 參考：
>
> [Apple Developer - Start Developing iOS Apps (Swift)](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/CreateATableView.html#//apple_ref/doc/uid/TP40015214-CH8-SW1)
>
> [urlsession-tutorial-getting-starte])(https://www.raywenderlich.com/567-urlsession-tutorial-getting-started)
>
> [NetworkingUintTest](https://github.com/koromiko/Tutorial/tree/master/NetworkingUnitTest.playground)
>
> [Swift開發指南：Protocols與Protocol Extensions的使用心法](https://www.appcoda.com.tw/swift-protocol/)