import React from "react";
import ReactDom from "react-dom";
import ReactComponent from "./component/reactout";
import Demo1 from "./component/demo";

if(document.getElementById("content")) {
  ReactDom.render(
    <ReactComponent />,
    document.getElementById("content")
  )
}

if(document.getElementById("demo1")) {
  ReactDom.render(
    <Demo1 />,
    document.getElementById("demo1")
  )
}
