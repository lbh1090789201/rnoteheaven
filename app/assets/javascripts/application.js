// = require jquery
//= require messages_zh.min

//= require bootstrap.min
//= require bootstrap/alert
//= require summernote.min
//= require summernote-zh-CN

// 监听事件兼容所有浏览器
// useCapture 为true时，事件在捕获阶段被执行，false则为冒泡阶段
function addListener(element, event, linstener, useCapture) {
  if(element.addEventListener) {
    element.addEventListener(event, listener, useCapture);
  }else if(element.attchEvent) {
    element.attchEvent("on" + event, listener);
  }
}

// page首页读取文章
function articleView(obj_id) {

  $(obj_id).delegate("a", "click", function(e){
    var article_id = parseInt(e.target.getAttribute("index")),
        tag_li = e.target.parentNode,
        index = $(e.target.parentNode.parentNode).children().index(tag_li);
        win_width = $(document).width(),
        text = e.target.getAttribute("name");

    if(win_width <= 768) {
      window.location.href = "/articles/" + article_id
    }else {
      $.ajax({
        url: "/pages/" + article_id,
        type: "GET",
        success: function(data) {
          var article = data.article;
          if(text == "最新") {
            $("#article_list_new li").eq(index).addClass('on').siblings().removeClass("on");
            $("#most_new .article-info").children().remove();
            $("#most_new .article-info").html('<a class="read-text" href="/articles/'+article.article.id+'">全文阅读</a>'+'<div><h1>'+article.article.title+
              '</h1><p class="article-author">作者: <span>'+article.show_name+
              '</span></p></div><article class="from-hot">'+article.article.content+'</article>');
          }else{
            $("#article_list_hot li").eq(index).addClass('on').siblings().removeClass("on");
            $("#most_hot .article-info").children().remove();
            $("#most_hot .article-info").html('<a class="read-text" href="/articles/'+article.article.id+'">全文阅读</a>'+'<div><h1>'+article.article.title+
              '</h1><p class="article-author">作者: <span>'+article.show_name+
              '</span></p></div><article class="from-hot">'+article.article.content+'</article>');
          }
          $(".article-intro").scrollTop(0);
        },
        error: function(err) {
          console.log("查询失败")
        }
      })
    }
  })
}

// 轮播图
function slidePhoto(obj_class) {
  var ul = $(obj_class),
      width = ul.children().eq(0).width();
  var timer = setInterval(function(){
    ul.animate({"left": "-=" + width + "px"}, 1500, function(){
      var ul = $(obj_class),
          li = ul.children('li').eq(0);
      li.remove();
      ul.append(li);
      ul.animate({"left": "+=" + width + "px"}, 0);
    })
  }, 7000)
}

// 成功弹窗
function successAlert(text) {
  var success_alert = $("<p>"+text+"</p>"),
      parent_element = $("#wrap");
  success_alert.css({
              "position": "absolute",
              "top": "0.6rem",
              "left": "25%",
              "width": "75%",
              "background": "#dff0d8",
              "paddingLeft": "0.1rem",
              "lineHeight": "0.3rem",
              "height": "0.3rem",
              "zIndex": "10000",
              "color": "#468847"
          });
  parent_element.append(success_alert)
  var timer = setInterval(function() {
    success_alert.remove();
  }, 4000)
}

// 失败弹窗
function fairAlert(text) {
  var fair_alert = $("<p>"+text+"</p>"),
      parent_element = $("#wrap");
  fair_alert.css({
              "position": "fixed",
              "top": "0.6rem",
              "left": "25%",
              "width": "75%",
              "background": "#f2dede",
              "paddingLeft": "0.1rem",
              "lineHeight": "0.6rem",
              "height": "0.6rem",
              "zIndex": "10000",
              "color": "#b94a48"
          });
  parent_element.append(fair_alert)
  var timer = setInterval(function() {
    fair_alert.remove();
  }, 4000)
}

// 推荐和收藏文章向后台发送数据
function ajaxSendData(article_id, user_id, url, text ) {
  $.ajax({
    url: url,
    type: "post",
    data: {
      note_id: article_id,
      user_id: user_id
    },
    success: function() {
      successAlert(text + "文章成功！");
    },
    error: function() {
      fairAlert(text + "文章失败！");
    }
  })
}
