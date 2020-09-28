websocket 可以在 webui 中使用，具体的 js 代码如下：
```js
// websocket for topbar start
if ("WebSocket" in window) {
  console.log("您的浏览器支持WebSocket"); 
  var ws = new WebSocket("ws://120.77.212.58:30159/ws/quotes"); //创建WebSocket连接　　　　
  //申请一个WebSocket对象，参数是服务端地址，同http协议使用http://开头一样，WebSocket协议的url使用ws://开头，另外安全的WebSocket协议使用wss://开头
  ws.onopen = function(){
  　　//当WebSocket创建成功时，触发onopen事件
    console.log("websocket of topbar open");
  　 ws.send("hello"); //将消息发送到服务端
  }
  ws.onmessage = function(e){
  　//当客户端收到服务端发来的消息时，触发onmessage事件，参数e.data包含server传递过来的数据
    var newTopbarData = [];
    var eData = JSON.parse(e.data);
    eData.forEach((item) => {
      var arr = item.split(",");
      var str = {
        kindName: arr[0],
        kindId: +arr[1],
        sellPrice: +arr[2],
        buyPrice: +arr[3],
        openPrice: +arr[4],
        closePrice: +arr[5],
        highest: +arr[6],
        lowest: +arr[7],
        spread: +arr[8],
        dataTime: arr[9],
        changePrice: arr[10],
        changePercent: arr[11],
        origin: +arr[12],
        dataTimeZone: +arr[13],
      };
      newTopbarData.push(str);
    });
    //获取topbar数据并渲染
    var topbarStr = "";
    for (var i = 0; i < newTopbarData.length; i++) {
      var { kindName, changePercent, changePrice } = newTopbarData[i];
      if (changePrice.indexOf("+") != -1) {
        topbarStr += `      <div class="topbar-item">
      <div class="topbar-item-first">
        <div class="topbar-item-title arial">${kindName}</div>
        <div class="topbar-item-value arial">${changePercent}</div>
      </div>
      <div class="topbar-item-change">
        <div class="topbar-item-percent green arial">${changePrice}(${changePercent})</div>
        <svg class="topbar-item-icon icon green" aria-hidden="true">
          <use xlink:href="#icon-arrow_up"></use>
        </svg>
      </div>
    </div>`;
      } else if (changePrice.indexOf("-") != -1) {
        topbarStr += `      <div class="topbar-item">
        <div class="topbar-item-first">
          <div class="topbar-item-title arial">${kindName}</div>
          <div class="topbar-item-value arial">${changePercent}</div>
        </div>
        <div class="topbar-item-change">
          <div class="topbar-item-percent red arial">${changePrice}(${changePercent})</div>
          <svg class="topbar-item-icon icon red" aria-hidden="true">
            <use xlink:href="#icon-arrow_down"></use>
          </svg>
        </div>
      </div>`;
      }
    }
    document.getElementById("topbar").innerHTML = topbarStr;
  }
  ws.onclose = function(e){
  　　//当客户端收到服务端发送的关闭连接请求时，触发onclose事件
  　　console.log("websocket of topbar close");
  }
  ws.onerror = function(e){
  　　//如果出现连接、处理、接收、发送数据失败的时候触发onerror事件
  　　console.log(error);
  }
}else{　　　　
  console.log("您的浏览器不支持WebSocket");　　
}

//websocket end
```