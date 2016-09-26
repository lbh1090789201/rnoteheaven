var AdminDataStatisticForm = React.createClass({
  handleFocus: function(e) {
    let id = e.target.id
    myDatePicker(id, 'time_from', 'time_to')
  }
  ,render: function() {
    let action_1 = this.props.dad.state.hospital_collect_action,
        action_2 = this.props.dad.state.hospital_deliver_action,
        action_3 = this.props.dad.state.job_deliver_action

    return (
      <form onSubmit={this.props.dad.handleSubmit} id="data_statistics">

        <div className="col-sm-3">
          <input type="text" id="time_from" name="time_from" ref="time_from" className=" form-control"
                required  placeholder="从" onFocus={this.handleFocus} />
        </div>

        <div className="col-sm-3">
          <input type="text" id="time_to" name="time_to" ref="time_to" className=" form-control"
                required  placeholder="至" onFocus={this.handleFocus} />
        </div>


        <div className="inquiry-input">
          <div className={action_3 + " " + "col-sm-4"}>
            <input type="text" id="hot_job_deliver" name="hot_job_deliver" ref="hot_job_deliver" className=" form-control" placeholder="请输入职位全称" />
          </div>

          <div className={action_2 + " " + "col-sm-4"}>
            <input type="text" id="hot_hospital_deliver" name="hot_hospital_deliver" ref="hot_hospital_deliver" className=" form-control" placeholder="请输入机构全称" />
          </div>

          <div className={action_1 + " " + "col-sm-4"}>
            <input type="text" id="hot_hospital_collect" name="hot_hospital_collect" ref="hot_hospital_collect" className=" form-control" placeholder="请输入机构全称" />
          </div>

          <button type="submit" id="submit">查询</button>
        </div>
      </form>
    )
  }
})
