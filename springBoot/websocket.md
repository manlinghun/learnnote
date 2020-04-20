# WebSocket协议
## 介绍
* WebSocket 是一种通讯协议，通过单个TCP连接提供完全多工（full-duplex）通讯管道。WebScoket 协议于2011年被IETF标准化，作为 RFC 6455，同时 Web IDL中的 WebSocket API 正在被W3C 标准化。
* WebSocket 被 Web浏览器与Web服务器实现，然而它能用于任何客户端或服务器应用。WebSocket 协议是基于TCP的独立协议。
## 历史
* WebSocket 首次引述于 HTML 5 规范中的 TCPConnection，在2008年6月，由Michael Carter 领导一系列的讨论，得出协议的第一个版本。
* 在WebSocket协议被多种浏览器默认激活并且投入使用后，于2011年12月，最终编入RFC。
~~~txt
注：
* IETF ：Internet Engineering Task Force，一个开放的组织，致力于开发和提升因特网标准。
* RFC：Request for Comments，一种IETF发行类型。
~~~
## 协议握手
    为建立一个WebSocket 连接，客户端发送WebSocket 握手请求，服务器返回握手的响应。
* 客户端请求：
~~~txt
    GET /text HTTP/1.1Upgrade: WebSocketConnection: Upgrade
    Host: www.example.com
    Origin: http://example.com
    WebSocket-Protocol: sample
~~~
* 服务端响应：
~~~txt
    HTTP/1.1 101 WebSocket Protocol Handshake
    Upgrade: WebSocket
    Connection: Upgrade
    WebSocket-Origin: http://example.com
    WebSocket-Location: ws://example.com/demo
    WebSocket-Protocol: sample
~~~
## 端点生命周期（Endpoint Lifecycle）
### 打开连接
Endpoint#onOpen(Session,EndpointConfig)
@OnOpen
### 关闭连接
Endpoint#onClose(Session,CloseReason)
@OnClose
### 错误
Endpoint#onError(Session,Throwable)
@OnError
## 会话（Sessions）
* API：javax.websocket.Session
* 接受消息：javax.websocket.MessageHandler
    * 部分
    * 整体
* 发送消息：javax.websocket.RemoteEndpoint.Basic
配置（Configuration）
### 服务端配置（javax.websocket.ServerEndpointConfig）
* URI 映射
* 子协议协商
* 扩展点修改
* Origin检测
* 握手修改
* 自定义端点创建
### 客户端配置（javax.websocket.ClientEndpointConfig）
* 子协议
* 扩展点
* 客户端配置修改
## 部署（Deployment）
### 应用部署到Web 容器
WEB-INF/classes
WEB-INF/lib
### 应用部署到独立WebSocket 服务器
javax.websocket.server.ServerApplicationConfig
### 编程方式
javax.websocket.server.ServerContainer

## Demo:聊天室
1. 定义websorcket配置类
~~~java
import org.apache.catalina.session.StandardSessionFacade;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
/**
 * @Author: joddon
 * @Date: 2020/3/15 9:39
 * @Version: 1.0
 * @Description:
 */
@Configuration
public class WebSocketConfig extends ServerEndpointConfig.Configurator {

    private static final Logger log = LoggerFactory.getLogger(WebSocketConfig.class);


    @Override
    /**
     * 修改握手信息
     */
    public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
        StandardSessionFacade ssf = (StandardSessionFacade) request.getHttpSession();
        if(ssf!=null){
            //主要实现将sessionId保存到用户属性
            HttpSession httpSession = (HttpSession) request.getHttpSession();
            sec.getUserProperties().put("sessionId",httpSession.getId());
            log.info("获取到信息的SessionID:"+httpSession.getId());
        }
        super.modifyHandshake(sec, request, response);
    }


    /**
     * 暴露器，需要将Endpoint暴露出来
     * @return
     */
    @Bean
    public ServerEndpointExporter serverEndpointExporter(){
        //这个对象说一下，貌似只有服务器是tomcat的时候才需   要配置,具体我没有研究
        return new ServerEndpointExporter();
    }

}
~~~
1. 创建服务端
~~~java
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.servlet.http.HttpSession;
import javax.websocket.*;

import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.joddon.springboottest1.config.WebSocketConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * @Author: joddon
 * @Date: 2020/3/15 9:48
 * @Version: 1.0
 * @Description:
 */
 //ServerEndpoint注解，定义value及URL连接 ，并传入配置类
@ServerEndpoint(value = "/websocket/{id}", configurator = WebSocketConfig.class)
@Component
public class WebSocketServer {
    static Logger log = LoggerFactory.getLogger(WebSocketServer.class);
    //静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
    private static int onlineCount = 0;
    private static ConcurrentHashMap<String, WebSocketServer> webSocketSet = new ConcurrentHashMap<>();

    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private Session session;

    //指定的sid，具有唯一性，暫定為用戶id
    private String sid = "";

    //
    private static volatile Set<String> allIds= new HashSet<String>();

    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(@PathParam("id") String id, Session session, EndpointConfig config) {
        //获取WebsocketConfig.java中配置的“sessionId”信息值
        String httpSessionId = (String) config.getUserProperties().get("sessionId");
        this.session = session;
        this.sid = id;
        allIds.add(id);
        webSocketSet.put(id,this);     //加入set中
        // 建立连接时
        JSONObject jo = new JSONObject();
        jo.put("s_userId","-1");
        jo.put("s_userName","系统");
        jo.put("msg","用戶"+id+"加入！当前在线人数为" + getOnlineCount());
        try {
            sendtoUser(jo.toString(),null);
        } catch (IOException e) {
            System.out.println("IO异常");
        }
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose() {
        webSocketSet.remove(this);  //从set中删除
        log.info("有一连接关闭！当前在线人数为" + getOnlineCount());
    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message, Session session) {
        log.info("收到来自窗口信息:" + message);
        //群发消息
    }

    /**
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        log.error("发生错误");
        error.printStackTrace();
    }

    /**
     * 实现服务器主动推送
     */
    public void sendMessage(String message) throws IOException {

        this.session.getBasicRemote().sendText(message);
    }


    /**
     * 发送消去指定用户
     */
    public  boolean sendtoUser(String message,String sendUserId) throws IOException {
        // 
        if(sendUserId==null || StringUtils.isEmpty(sendUserId)){
            for (String key : webSocketSet.keySet()) {
                try {
                    webSocketSet.get(key).sendMessage(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }else {
            if (webSocketSet.get(sendUserId) != null) {
                if(!allIds.contains(sendUserId)){
                    log.info("未找到匹配用戶");
                    return false;
                }{
                    webSocketSet.get(sendUserId).sendMessage(message);
                    try {
                        Thread.sleep(100);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    log.info("消息發送成功");
                    return true;
                }
            } else {
                //如果用户不在线则返回不在线信息给自己
                log.info("未找到匹配用戶");
                return false;
            }
        }
        return true;
    }




    public static synchronized int getOnlineCount() {
        return allIds.size();
    }

}

~~~




