var AdminHospitalNew = React.createClass({
  getInitialState: function() {
    return {
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
      new_display: false,
    })
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    var formData = new FormData(e.target)
    formData.append('plan_id',this.state.vip_id);
    console.log(this.state.vip_id)

    $.ajax({
      url: "/admin/hospitals",
      type: "POST",
      data: formData,
      processData: false,
      contentType: false,
      success: function(data) {
        let hospitals = this.props.dad.state.hospitals

        hospitals.push(data.hospital)

        this.props.dad.setState({
          hospitals: hospitals,
          new_display: false,
        })
      }.bind(this),
      error: function(data) {
        console.log(data.responseText)
        this.props.dad.setState({
        new_display: false,
        })
      }.bind(this),
    })
  }
  ,render: function() {
    var plans = this.props.plans,
        select_plan = plans.map(
          function(plan, index) {
            return (
              <option key={plan.id} value={plan.id}>{plan.name}</option>
            )
          }.bind(this)
        )

    return (
      <div className="mask-user">
        <div className="user-box">
          <form onSubmit={this.handleSubmit}>
            <div className="row">
              <div className="form-group col-sm-4">
                 <label>账号(手机号)</label>
                   <input type="text" className="form-control" placeholder="手机号码" name="contact_number"
                          pattern=""  required ref="contact_number"/>
              </div>

              <div className="form-group col-sm-4">
                 <label>机构名称</label>
                   <input className="form-control" type="text" placeholder="机构名称"
                      name="name" required ref="hospital_name" />
              </div>

              <div className="form-group col-sm-4">
                 <label>负责人</label>
                   <input type="text" className="form-control" placeholder="姓名" name="contact_person"
                            required ref="contact_person"/>
              </div>



              <div className="form-group col-sm-4">
                 <label>行业</label>
                   <input type="text" className="form-control" placeholder="行业" name="industry"
                                 required ref="industry" />
              </div>

              <div className="form-group col-sm-4">
                 <label>性质</label>
                   <input type="text" className="form-control" placeholder="性质" name="property"
                                 required ref="property" />
              </div>

              <div className="form-group col-sm-4">
                 <label>规模</label>
                   <input type="text" className="form-control" placeholder="规模" name="scale"
                              required ref="scale" />
              </div>

              <div className="form-group col-sm-4">
                 <label>地区</label>
                   <input type="text" className="form-control" placeholder="地区" name="region"
                             required ref="region" />
              </div>

              <div className="form-group col-sm-4">
                 <label>级别配置</label>
                 <select onChange={this.handleSelect} name="vip_name" className="form-control" >
                   {select_plan}
                 </select>
              </div>
            </div>

            <div className="row">

              <div className="form-group col-sm-4">
                 <label>经度</label>
                   <input type="text" className="form-control" placeholder="经度" name="lng"
                             required ref="lng" />
              </div>

              <div className="form-group col-sm-4">
                 <label>纬度</label>
                   <input type="text" className="form-control" placeholder="纬度" name="lat"
                             required ref="lat" />
              </div>

              <div className="form-group col-sm-4">
                <label>拾取坐标</label>
                <button className="btn btn-default btn-map">
                  <a href="http://api.map.baidu.com/lbsapi/getpoint/index.html" target="_blank">
                    点击拾取
                  </a>
                </button>
              </div>

            </div>

            <div className="form-group col-sm-12">
               <label>机构地址</label>
                 <input type="text" className="form-control" placeholder="机构地址" name="location"
                           required ref="location" />
            </div>

            <div className="form-group col-sm-12">
               <label>机构介绍</label>
                 <textarea type="text" className="form-control" placeholder="机构介绍" name="introduction" rows="5"
                          pattern=".{6,}" required title="最少6个字符" ref="introduction" />
            </div>

            {
              // <div className="form-group">
              //   <div>{this.state.plan.name}:
              //      <span>可发布职位{this.state.plan.may_release}个</span>
              //      <span>可置顶职位{this.state.plan.may_set_top}个</span>
              //      <span>可接收简历{this.state.plan.may_receive}份</span>
              //      <span>可查看简历{this.state.plan.may_view}份</span>
              //      <span>可参加专场{this.state.plan.may_join_fairs}次</span>
              //   </div>
              // </div>
            }


            <button type="button" className="btn btn-secondary btn-bottom" onClick={this.handleClick}>取消</button>
            <button type="submit" className="btn btn-success btn-bottom">提交</button>
          </form>
        </div>
      </div>
    )
  }
})
