# Controller接收参数的集中范式

## 第一类：请求路径参数

### @PathVariable
* 获取路径参数。即url/{id}这种形式。
~~~java
    // getData/123/aaa
    @RequestMapping("/getData/{id}/{name}")
    public String getData(@PathVariable("id") String id, @PathVariable("name") String desc) {
        return id + ":" + desc;
    }
~~~

### @RequestParam
* 获取查询参数。即url?id=XXX&name=XXX这种形式
~~~java
    // getData2?name=1&id=2
    @RequestMapping("/getData2")
    public String getData2(@RequestParam("id") String id,@RequestParam("name")String desc) {
        return id + ":" + desc;
    }
~~~

### @PathVariable和@RequestParam混用
~~~java
    // getData3/111?name=1
    @RequestMapping("/getData3/{id}")
    public String getData3(@PathVariable("id") String id,@RequestParam("name")String desc) {
        return id + ":" + desc;
    }
~~~


## 第二类：Body参数

### @RequestBody
* required参数:
    * true: 默认参数，请求时，参数不传会报错
    * false: 不传参数不会报错，不传整个bean为null
~~~java     
    // body必传内容，否则报错
    @RequestMapping("/getData4")
    public Object getData4(@RequestBody User user){
        return user;
    }
    // body可以没有内容，此时user为null
    @RequestMapping("/getData5")
    public Object getData5(@RequestBody(required = false) User user){
        return user;
    }
~~~

~~~java
    public class User {
        String name;
        Integer age;
        int sex;
        Car car;
        List<Car> carList;
    }

    public class Car {
        String name;
    }
~~~

~~~json
{
    "name": "aaa",
    "age": 26,
    "sex": 1,
    "car": {
        "name": "长安 第二代 CS55 PLUS"
    },
    "carList": [
        {
            "name": "黑色雅迪"
        },
        {
            "name": "白色雅迪"
        }
    ]
}
~~~

### 不带注解
~~~java 
    // 
    @RequestMapping("/getData6")
    public Object getData6(User user){
        return user;
    }
~~~

### 两者的区别
1. 使用注解且required属性为false，body内容为空时，接收的Bean为null；不使用注解，接收的Bean不为null，只是各项属性值为默认值
2. 不使用注解必须是key-value结构传递，使用注解，必须Content-Type=application/json;charset=utf-8
3. TODO 需要仔细研究下源码

## 获取请求头数据和Cookie的数据

### 请求头数据：@RequestHeader
~~~java
    @RequestMapping("/getData7")
    public Object getData7(@RequestHeader("Token") String accept){
        return accept;
    }
~~~
### Cookie数据：@CookieValue
~~~java
    @RequestMapping("/getData8")
    public Object getData8(HttpServletRequest request){
        List<String> result = new ArrayList<String>();
        Cookie[] cookies = request.getCookies();
        if(cookies!=null){
            for (Cookie cookie : cookies) {
                String name = cookie.getName();
                String value = cookie.getValue();
                result.add(name+" -> "+value);
            }
        }
        return result;
    }
~~~


