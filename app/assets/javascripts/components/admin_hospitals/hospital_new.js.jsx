var AdminHospitalNew = React.createClass({
  getInitialState: function() {
    return {
      plan: '',
      index: this.props.dad.state.hos_info.index,
      vip_id: this.props.plans[0].id,
      property: '',
    }
  }
  ,componentDidMount: function() {
    formHospital('#form_hospital_new')
  }
  ,handleSelect: function(e) {
    this.setState({
      vip_id: e.target.value,
    })
  }
  ,SelectValue: function(e) {
    this.setState({
      property: e.target.value,
    })
  }
  ,handleBlur: function(e) {
    var value = e.target.value

    // if(value.length < 6){
    //   alert("机构介绍长度不能少于６!")
    // }
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
      new_display: false,
    })
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    if(invalid('#form_hospital_new')) return // 不合法就返回

    var formData = new FormData(e.target)
    formData.append('plan_id',this.state.vip_id);
    formData.append('property',this.state.property);

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

        myInfo('新建机构成功！', 'success')
      }.bind(this),
      error: function(data) {
        let info = JSON.parse(data.responseText)
        myInfo(info["info"], 'fail')
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
          <form onSubmit={this.handleSubmit} id='form_hospital_new'>
            <div className="row">
              <div className="form-group col-sm-4">
                 <label>账号(手机号)</label>
                   <input type="tel" className="form-control" placeholder="手机号码" name="contact_number"
                            pattern="^1[345678][0-9]{9}$" required ref="contact_number"/>
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
            </div>

            <div className="row">
              <div className="form-group col-sm-4">
                <select name="industry" className="form-control form-magrin-top" defaultValue="行业">
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
                <select name="property" className="form-control form-magrin-top" onChange={this.SelectValue}>
                  <option value="">性质</option>
                  <option value="综合医院">综合医院</option>
                  <option value="专科医院">专科医院</option>
                  <option value="民营医院">民营医院</option>
                  <option value="公立诊所">公立诊所</option>
                  <option value="民营诊所">民营诊所</option>
                </select>
              </div>

              <div className="form-group col-sm-4">
                 <select className="form-control form-magrin-top" name="scale">
                   <option value="">规模</option>
                   <option value="10人以下">10人以下</option>
                   <option value="10~50人">10~50人</option>
                   <option value="50~200人">50~200人</option>
                   <option value="200~500人">200~500人</option>
                   <option value="500~1000人">500~1000人</option>
                   <option value="1000人以上">1000人以上</option>
                 </select>
              </div>
            </div>

            <div className="row">
              <div className="form-group col-sm-4">
                 <label>地区</label>
                   <input type="text" className="form-control" id="cityChoice" placeholder="地区" name="region"
                             onFocus={this.handlefocus} required ref="region" />
                  <input type="hidden" id="province" value="" ref="region_2" />
                   <input type="hidden" id="city" value="" ref="region_3" />
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
                 <label>经度(73°E~135°E)</label>
                   <input type="text" className="form-control" placeholder="请填写数字" name="lng"
                            pattern="^[+-]?\d+(\.\d+)?$" required ref="lng" />
              </div>

              <div className="form-group col-sm-4">
                 <label>纬度(4°N~53°N)</label>
                   <input type="text" className="form-control" placeholder="请填写数字" name="lat"
                            pattern="^[+-]?\d+(\.\d+)?$" required ref="lat" />
              </div>

              <div className="form-group col-sm-4">
                <label>拾取坐标</label>
                <button className="btn btn-default btn-map">
                  <a className="btn-href" href="http://api.map.baidu.com/lbsapi/getpoint/index.html" target="_blank">
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
                 <textarea id="input_textarea" className="form-control input-textarea" placeholder="机构介绍" name="introduction"
                           required ref="introduction" ></textarea>

            </div>

            <button type="button" className="btn btn-secondary btn-bottom" onClick={this.handleClick}>取消</button>
            <button type="submit" className="btn btn-success btn-bottom">提交</button>
          </form>
        </div>
      </div>
    )
  }
})




/**********************AdminHospitalMassNew**********************/
var AdminHospitalMassNew = React.createClass({
  handleClick: function() {
    this.props.dad.setState({
      mass_display: false,
    })
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    var formData = new FormData(e.target)
    $.ajax({
      url: '/api/v1/admin_hospitals',
      type: 'POST',
      data: formData,
      processData: false,
      contentType: false,
      success: function(data) {

        this.props.dad.setState({
          mass_display: false,
        })

        successNew("批量导入机构成功！")

      }.bind(this),
      error: function(data) {
        let info = JSON.parse(data.responseText)
        myInfo(info["info"], 'fail')
      }.bind(this)
    })
  }
  ,render: function() {
    return (
      <div className="mask-user">
        <div className="user-box">
          <form onSubmit={this.handleSubmit} style={{'height':'100px'}} enctype="multipart/form-data">
            <input type="file" name="hospital" accept=".csv" className="form-control" />
            <button type="button" className="btn btn-secondary btn-bottom" onClick={this.handleClick}>取消</button>
            <button type="submit" className="btn btn-success btn-bottom">提交</button>
          </form>
        </div>
      </div>
    )
  }
})
