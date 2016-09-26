var AdminDataHospitalCollect = React.createClass({
  getInitialState: function() {
    return {
      hospital_collect_action: this.props.action,
      data_table: false,
      data_picture: false,
      datas: '',
    }
  }
  ,handleClick: function(e) {
    let text = e.target.innerText

    if(text == "统计表") {
      $(".select-button > button").eq(0).addClass('data-table').siblings().removeClass('data-table');

      this.setState({
        data_table: true,
      })
    }else{
      $(".select-button > button").eq(1).addClass('data-table').siblings().removeClass('data-table');

      this.setState({
        data_picture: true,
      })
    }
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    if(invalid('#data_statistics')) return // 不合法就返回

    let time_from = $("#time_from").val(),
        time_to = $("#time_to").val(),
        hot_hospital_collect = $("#hot_hospital_collect").val()

    if(hot_hospital_collect == '') {
      myInfo("机构名称不能为空！", 'fail')
      return
    }

    $.ajax({
      url: "/admin/data_statistics/hospital_collects",
      type: "GET",
      data: {
        time_from: time_from,
        time_to: time_to,
        hot_hospital_collect: hot_hospital_collect,
        search: true,
      },
      success: function(data) {
        // 趋势图函数
        // trendChart("#data_statistic", data.data_statistic)
      }.bind(this),
      error: function(data) {
        console.log('搜索失败')
      }.bind(this),
    })
  }
  ,render: function() {
    return (
      <div className="admin-statistics">
        <AdminDataStatisticForm dad={this} />

        <div className="select-button">
          <button className="data-picture data-table" onClick={this.handleClick}>统计表</button>
          <button className="data-picture" onClick={this.handleClick}>趋势图</button>
        </div>

        <AdminDataHospitalCollectTable dad={this} />

        <div id="data_statistic" style={{"minwidth":"310px","height":"400px","position":"relative","top":"30px"}}>
        </div>
      </div>
    )
  }
})

/*****************AdminDataHospitalCollectTable*******************/
var AdminDataHospitalCollectTable = React.createClass({
  render: function() {
    let datas = this.props.dad.state.datas

    function hospital_collect_map() {
      if(datas != '') {
          datas.map(function(data, index) {
            <AdminDataHospitalCollectTableTbody key={data.id} data={data} index={index} />
          })
      }
    }

    return (
      <table className="table table-bordered">
        <thead>
          <tr>
            <td>序号</td>
            <td>收藏者</td>
          </tr>
        </thead>
          {
            hospital_collect_map()
          }
      </table>
    )
  }
})



var AdminDataHospitalCollectTableTbody = React.createClass({
  render: function() {
    return (
      <tbody>
          <tr>
            <td>序号</td>
            <td>收藏者</td>
          </tr>
      </tbody>
    )
  }
})
