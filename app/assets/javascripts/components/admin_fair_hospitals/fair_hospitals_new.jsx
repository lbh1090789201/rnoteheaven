var FairHospitalNew = React.createClass({
  getInitialState: function() {
    return {
      divStyle: {
        backgroundImage: '',
      },
      gold: this.props.dad.state.gold
    }
  }
  ,componentDidMount: function() {
    formFairHospital('#form_hospital_new')

    $('.preview-img').on('click', function(){
      $(".upload-file").trigger('click')
    })
  }
  ,handleChange: function(e) {
    let url = URL.createObjectURL(e.target.files[0])

    $('.preview-img').css('background-image', 'url(' + url + ')')
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    if(invalid('#form_hospital_new')) return // 不合法就返回

    let formData = new FormData(e.target),
        fair_id = this.props.dad.state.fair.id

    $.ajax({
      url: '/admin/fairs/' + fair_id + '/fair_hospitals',
      type: 'POST',
      data: formData,
      contentType: false,
      processData: false,
      success: function(data){
        let  fair_hospitals = this.props.dad.state.fair_hospitals

        fair_hospitals.push(data.fair_hospital)
        this.props.dad.setState({
           fair_hospitals: fair_hospitals,
           new_display: false
        })

        myInfo('机构添加成功！', 'success')
      }.bind(this),
      error: function(data){
        let info = JSON.parse(data.responseText)
        myInfo(info["info"], 'fail')
      }
    })
  }
  ,render: function() {
    let gold = this.props.dad.state.gold

    return (
      <div className="mask-user">
        <div className="user-box">
          <form method="post" action="/admin/fairs" id="form_hospital_new"
                encType="multipart/form-data" onSubmit={this.handleSubmit}>
            <div className="gold-info">
            <span className="col-sm-4 limit-width"><label>机构名称：</label>{gold.name}</span>
            <span className="col-sm-4"><label>机构帐号：</label>{gold.contact_number}</span>
            <span className="col-sm-4"><label>负责人：</label>{gold.contact_person}</span>
            </div>

            <div className="form-group col-sm-6">
               <label>专场联系人</label>
               <input type="text" className="form-control" name="contact_person"
                      pattern=".{1,}" required ref="contact_person" />
            </div>

            <div className="form-group col-sm-6">
               <label>手机号码</label>
               <input type="tel" className="form-control" name="contact_number"
                      required  ref="contact_number" />
            </div>

            <div className="form-group col-sm-12">
               <label>机构介绍</label>
               <textarea className="form-control" name="intro" rows="5"
                                required ref="intro" />
            </div>

            <div className="form-group col-sm-12">
               <label>上传图片</label>
               <input type="file" className="form-control upload-file" onChange={this.handleChange}
                      required style={{'display':'none'}} name="banner" ref="banner" />

                <div className="preview-img"></div>
            </div>

            <input className="hidden" name="status" defaultValue="on" />
            <input className="hidden" name="hospital_id" defaultValue={gold.id} />

            <button type="button" className="btn btn-bottom btn-secondary"
                    onClick={this.props.dad.handleClick} name="new_display" value="false" >取消</button>

            <button type="submit" className="btn btn-bottom btn-success">提交</button>
          </form>
        </div>
      </div>
    )
  }
})
