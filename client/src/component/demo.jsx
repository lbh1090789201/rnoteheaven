import React from "react";

export default class Demo1 extends React.Component{
  handleClick() {
    alert("弹窗警告!");
  }
  render() {
    return (
      <div>
        <button style={{"width":"200px","height":"300px"}} onClick={this.handleClick.bind(this)}>
          这是一个点击按钮(测试)
        </button>
        <p id="asd"></p>
      </div>
    )
  }
}
