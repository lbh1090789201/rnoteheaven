var FairHospitalEdit = React.createClass({
  getInitialState: function() {
    return {
      divStyle: {
        backgroundImage:'url(' + this.props.dad.state.fair_hospital.banner.url + ')',
      },
      gold: this.props.dad.state.gold,
      fair_hospital: this.props.dad.state.fair_hospital,
      index: this.props.dad.state.index,
    }
  }
  ,handleChange: function(e) {
    let url = URL.createObjectURL(e.target.files[0])

    this.setState({
      divStyle: {
        backgroundImage: 'url(' + url + ')',
      }
    })
  }
  ,handleSubmit: function(e) {
    e.preventDefault()
    let formData = new FormData(e.target),
        fair_id = this.props.dad.state.fair.id,
        fair_hospital_id = this.state.fair_hospital.id,
        index = this.state.index

    $.ajax({
      url: '/admin/fairs/' + fair_id + '/fair_hospitals/' + fair_hospital_id,
      type: 'PATCH',
      data: formData,
      contentType: false,
      processData: false,
      success: function(data){
        let  fair_hospitals = this.props.dad.state.fair_hospitals

        fair_hospitals[index] = data.fair_hospital
        this.props.dad.setState({
           fair_hospitals: fair_hospitals,
           edit_display: false
        })
      }.bind(this),
      error: function(data){
        alert(data.responseText)
        this.props.dad.setState({
            edit_display: false,
        })
      }
    })
  }
  ,render: function() {
    let gold = this.state.gold,
        fair_hospital = this.state.fair_hospital

    return (
      <div className="mask-user">
        <div className="user-box">
          <form method="post" action="/admin/fairs" encType="multipart/form-data" onSubmit={this.handleSubmit}>
            <div className="gold-info">
            <span className="col-sm-4"><label>机构名称：</label>{gold.name}</span>
            <span className="col-sm-4"><label>机构帐号：</label>{gold.id}</span>
            <span className="col-sm-4"><label>负责人：</label>{gold.contact_person}</span>
            </div>

            <div className="gold-info">
              <span className="col-sm-4"><label>操作人：</label>{fair_hospital.operator}</span>
              <span className="col-sm-4"><label>入驻时间：</label>{fair_hospital.created_at.slice(0, 10)}</span>
            </div>

            <div className="form-group col-sm-6">
               <label>专场联系人</label>
               <input type="text" className="form-control" name="contact_person" required title="专场联系人不能为空"
                      defaultValue={fair_hospital.contact_person} pattern=".{1,}" ref="contact_person" />
            </div>

            <div className="form-group col-sm-6">
               <label>手机号码</label>
               <input type="tel" className="form-control" name="contact_number" defaultValue={fair_hospital.contact_number}
                      pattern=".{1,}" required title="手机号码不能为空" ref="contact_number" />
            </div>

            <div className="form-group col-sm-12">
               <label>专场介绍</label>
               <textarea className="form-control" name="intro" rows="5" defaultValue={fair_hospital.intro}
                               pattern=".{6,}" required title="最少6个字符" ref="intro" />
            </div>

            <div className="form-group col-sm-12">
               <label>上传图片</label>
               <input type="file" className="form-control preview-img" onChange={this.handleChange}
                      style={this.state.divStyle} name="banner" ref="banner" />
            </div>

            <input className="hidden" name="status" defaultValue="on" />
            <input className="hidden" name="hospital_id" defaultValue={gold.id} />

            <button type="button" className="btn btn-bottom btn-secondary"
                    onClick={this.props.dad.handleClick} name="edit_display" value="false" >取消</button>

            <button type="submit" className="btn btn-bottom btn-success">提交</button>
          </form>
        </div>
      </div>
    )
  }
})
