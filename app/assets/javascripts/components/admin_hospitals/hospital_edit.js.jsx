var AdminEditHospital = React.createClass({
  getInitialState: function() {
    return {
      vip_id: 1,
      vip_name: this.props.data.vip_name,
      plan: '',
      index: this.props.dad.state.hos_info.index,
    }
  }
  ,handleSelect: function(e) {
    this.setState({
      vip_id: e.target.value,
    })
  }
  ,handleClick: function() {
    this.props.dad.setState({
      hos_info: {
        eidt_display: false,
      }
    })
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    var formData = new FormData(e.target)
    formData.append('plan_id',this.state.vip_id);
    console.log(this.state.vip_id)

    $.ajax({
      url: "/admin/hospitals/" + this.props.data.id,
      type: "PATCH",
      data: formData,
      processData: false,
      contentType: false,
      success: function(data) {
        let hospitals = this.props.dad.state.hospitals,
            index = this.state.index

        hospitals[index] = data.hospital[0]

        this.props.dad.setState({
          hospitals: hospitals,
          hos_info: {
            eidt_display: false,
          }
        })
      }.bind(this),
      error: function(data) {
        console.log(data.responseText)
        this.props.dad.setState({
          hos_info: {
            eidt_display: false,
          }
        })
      }.bind(this),
    })
  }
  ,render: function() {
    var plans = this.props.plans,
        select_plan = plans.map(
          function(plan, index) {
            return (
              <AdminHosEditPlanItem key={plan.id} data={plan} dad={this.props.dad} />
            )
          }.bind(this)
        )

    return (
      <div className="mask-user">
        <div className="user-box">
          <form onSubmit={this.handleSubmit}>
            <div className="form-group">
               <label>申请机构</label>
                 <input className="form-control" type="text" placeholder="机构名称"
                    name="name" required ref="hospital_name" defaultValue={this.props.data.hospital_name} />
            </div>

            <div className="form-group">
               <label>行业</label>
                 <input type="text" className="form-control" placeholder="行业" name="industry"
                               required ref="industry" defaultValue={this.props.data.industry} />
            </div>

            <div className="form-group">
               <label>性质</label>
                 <input type="text" className="form-control" placeholder="性质" name="property"
                               required ref="property" defaultValue={this.props.data.property} />
            </div>

            <div className="form-group">
               <label>规模</label>
                 <input type="text" className="form-control" placeholder="规模" name="scale"
                            required ref="scale" defaultValue={this.props.data.scale} />
            </div>

            <div className="form-group">
               <label>地区</label>
                 <input type="text" className="form-control" placeholder="地区" name="region"
                           required ref="region" defaultValue={this.props.data.region} />
            </div>

            <div className="form-group">
               <label>机构地址</label>
                 <input type="text" className="form-control" placeholder="机构地址" name="location"
                           required ref="location" defaultValue={this.props.data.location} />
            </div>

            <div className="form-group">
               <label>账号</label>
                 <input type="text" className="form-control" placeholder="账号" name="hospital_id"
                          required ref="id" defaultValue={this.props.data.id} />
            </div>

            <div className="form-group">
               <label>姓名</label>
                 <input type="text" className="form-control" placeholder="姓名" name="contact_person"
                          required ref="contact_person" defaultValue={this.props.data.contact_person} />
            </div>

            <div className="form-group">
               <label>手机号码</label>
                 <input type="text" className="form-control" placeholder="手机号码" name="contact_number"
                          required ref="contact_number" defaultValue={this.props.data.contact_number} />
            </div>

            <div className="form-group">
               <label>机构介绍</label>
                 <input type="text" className="form-control" placeholder="机构介绍" name="introduction"
                          required ref="introduction" defaultValue={this.props.data.introduction} />
            </div>

            <div className="form-group">
               <label>级别配置(当前级别：{this.props.data.vip_name})</label>
               <select onChange={this.handleSelect} className="form-control" >
                 {select_plan}
               </select>
            </div>

            <div className="form-group">
              <div>{this.state.plan.name}:
                 <span>可发布职位{this.state.plan.may_release}个</span>
                 <span>可置顶职位{this.state.plan.may_set_top}个</span>
                 <span>可接收简历{this.state.plan.may_receive}份</span>
                 <span>可查看简历{this.state.plan.may_view}份</span>
                 <span>可参加专场{this.state.plan.may_join_fairs}次</span>
              </div>
            </div>

            <button type="button" className="btn btn-secondary" onClick={this.handleClick}>取消</button>
            <button type="submit" className="btn btn-success">提交</button>
          </form>
        </div>
      </div>
    )
  }
})


/*************下拉框组件***************/
var AdminHosEditPlanItem = React.createClass({
  handleClick: function(e) {
    e.preventDefault()
    this.props.dad.setState({
      plan: this.props.data,
    })
  }
  ,render: function() {
    return (
      <option onMouseOver={this.handleClick} value={this.props.data.id} name="vip_name" ref="plan_info">{this.props.data.name}</option>
    )
  }
})
