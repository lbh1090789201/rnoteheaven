var FairHistroyView = React.createClass({
  getInitialState: function() {
    return {
      fair: this.props.dad.state.fair,
    }
  }
  ,render: function() {
    let fair = this.state.fair
    console.log(fair.banner.url)

    return (
      <div className="mask-user">
        <div className="user-box">
          <table>
            <tbody>
              <tr>
                <td>
                  <label>专场名称:</label>
                  <span>{fair.name}</span>
                </td>
                <td>
                  <label>发布人:</label>
                  <span>{fair.creator}</span>
                </td>
              </tr>
              <tr>
                <td>
                  <label>开始时间:</label>
                  <span>{fair.begain_at.slice(0, 10)}</span>
                </td>
                <td>
                  <label>结束时间:</label>
                  <span>{fair.end_at.slice(0, 10)}</span>
                </td>
              </tr>
              <tr>
                <td>
                  <label>参加机构数:</label>
                  <span>{fair.hospitals_count}</span>
                </td>
                <td>
                  <label>发布职位数:</label>
                  <span>{fair.jobs_count}</span>
                </td>
              </tr>
              <tr>
                <td>
                  <label>收到简历数:</label>
                  <span>{fair.resumes_count}</span>
                </td>
                <td>
                  <label>当前状态:</label>
                  <span>已结束</span>
                </td>
              </tr>
              <tr>
                <td>
                  <label>专场介绍:</label>
                  <span>{fair.intro}</span>
                </td>
              </tr>
            </tbody>
          </table>

          <div className="form-group">
             <label>专场图片:</label>
             <div><img src={fair.banner.url} /></div>
          </div>

        </div>
      </div>
    )
  }
})
