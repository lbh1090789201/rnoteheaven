var AdminEditHospital = React.createClass({
  getInitialState: function() {
    return {
      vip_id: this.props.data.vip_id,
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
  ,handlefocus: function() {
    var input_id = this.refs.region.id,
        province = this.refs.region_2.id,
        city = this.refs.region_3.id

     var city_left = $(".user-box").css('margin-left');
      var cityPicker = new IIInsomniaCityPickerEdit({
            data: cityData,
            target: '#'+input_id,
            valType: 'k-v',
            hideCityInput: '#'+city,
            hideProvinceInput: '#'+province,
            city_left: city_left,
            callback: function(){
              $(".IIInsomnia-city-picker").remove();
            }
        });
        cityPicker.init();
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
    var plans = this.props.plans

    var select_plan = plans.map(
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
            <div className="form-group col-sm-4">
               <label>账号</label>
                 <input type="text" className="form-control" placeholder="账号" name="contact_number"
                        disabled  required ref="contact_number" defaultValue={this.props.data.contact_number} />
            </div>

            <div className="form-group col-sm-4">
               <label>机构名称</label>
                 <input className="form-control" type="text" placeholder="机构名称"
                    name="name" required ref="name" defaultValue={this.props.data.name} />
            </div>

            <div className="form-group col-sm-4">
               <label>负责人</label>
                 <input type="text" className="form-control" placeholder="姓名" name="contact_person"
                          required ref="contact_person" defaultValue={this.props.data.contact_person} />
            </div>

            <div className="form-group col-sm-4">
               <label>联系电话</label>
                 <input type="text" className="form-control" placeholder="手机号码" name="contact_number"
                          required ref="contact_number" defaultValue={this.props.data.contact_number} />
            </div>

            <div className="form-group col-sm-4">
              <select name="industry" className="form-control form-magrin-top" defaultValue={this.props.data.industry}>
                <option value="">行业</option>
                <option value="医疗">医疗</option>
                <option value="医院">医院</option>
                <option value="美容">美容</option>
                <option value="卫生">卫生</option>
                <option value="医药">医药</option>
                <option value="医疗器械">医疗器械</option>
                <option value="整形">整形</option>
                <option value="口腔">口腔</option>
                <option value="门诊">门诊</option>
                <option value="诊所">诊所</option>
                <option value="药店">药店</option>
                <option value="保健">保健</option>
              </select>
            </div>

            <div className="form-group col-sm-4">
              <select name="property" className="form-control form-magrin-top" defaultValue={this.props.data.property}>
                <option value="">性质</option>
                <option value="综合医院">综合医院</option>
                <option value="专科医院">专科医院</option>
                <option value="民营医院">民营医院</option>
                <option value="公立诊所">公立诊所</option>
                <option value="民营诊所">民营诊所</option>
              </select>
            </div>

            <div className="form-group col-sm-4">
               <label>规模</label>
                 <input type="text" className="form-control" placeholder="规模" name="scale"
                            required ref="scale" defaultValue={this.props.data.scale} />
            </div>

            <div className="form-group col-sm-4">
               <label>地区</label>
                 <input type="text" className="form-control" id="cityChoice" placeholder="地区" name="region"
                           required ref="region" defaultValue={this.props.data.region} onFocus={this.handlefocus} />
                 <input type="hidden" id="province" value="" ref="region_2" />
                 <input type="hidden" id="city" value="" ref="region_3" />
            </div>

            <div className="form-group col-sm-4">
               <label>级别配置</label>(原：{this.props.data.vip_name})
               <select onChange={this.handleSelect} defaultValue={this.props.data.vip_id} className="form-control" >
                 {select_plan}
               </select>
            </div>

            <div className="form-group col-sm-12">
               <label>机构地址</label>
                 <input type="text" className="form-control" placeholder="机构地址" name="location"
                           required ref="location" defaultValue={this.props.data.location} />
            </div>

            <div className="form-group col-sm-12">
               <label>机构介绍</label>
                 <textarea type="text" className="form-control" placeholder="机构介绍" name="introduction" rows="5"
                          pattern=".{6,}" required title="最少6个字符" ref="introduction" defaultValue={this.props.data.introduction} />
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
