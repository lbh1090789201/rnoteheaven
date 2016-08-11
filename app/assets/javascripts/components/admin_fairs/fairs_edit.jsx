var FairEdit = React.createClass({
  getInitialState: function() {
    return {
      fair: this.props.dad.state.fair,
      status: this.props.dad.state.fair.status,
      divStyle: {
        backgroundImage: 'url(' + this.props.dad.state.fair.banner.url + ')',
      }
    }
  }
  ,componentDidMount: function() {
    formFair('#form_fair_edit')
  }
  ,handleChange: function(e) {
    let url = URL.createObjectURL(e.target.files[0])

    this.setState({
      divStyle: {
        backgroundImage: 'url(' + url + ')',
      }
    })
  }
  ,handleRadio: function(e) {
    this.setState({
      status: e.target.value,
    })
  }
  ,handleFocus: function(e) {
      let id = e.target.id

      myDatePicker(id, 'begain_at', 'end_at')
    }
  ,handleSubmit: function(e) {
    e.preventDefault()
    if(invalid('#form_fair_edit')) return // 不合法就返回

    let banner_file = this.refs.banner.files[0],
        formData = new FormData(e.target),
        id = this.refs.id.value.toString()

    console.log(e.target)
    console.log('---------------')
    console.log(formData)

    $.ajax({
      url: '/admin/fairs/' + id,
      type: 'PATCH',
      data: formData,
      contentType: false,
      processData: false,
      success: function(data){
        let  fairs = this.props.dad.state.fairs,
             index = this.props.dad.state.index

        fairs[index] = data.fair

        this.props.dad.setState({
           fairs: fairs,
           edit_display: false
        })

        myInfo('专场修改成功！', 'success')
      }.bind(this),
      error: function(data){
        var info = JSON.parse(data.responseText)
        myInfo(info["info"], 'fail')
      }
    })
  }
  ,render: function() {
    let fair = this.state.fair

    return (
      <div className="mask-user">
        <div className="user-box">
          <form method="post" action="/admin/fairs" id="form_fair_edit"
                encType="multipart/form-data" onSubmit={this.handleSubmit}>
            <div className="form-group col-sm-6">
               <label>专场名称</label>
               <input className="form-control" placeholder="专场名称" name="name" defaultValue={fair.name} ref="name" />
            </div>

            <div className="form-group col-sm-6">
               <label>发布人</label>
               <input type="text" className="form-control" name="creator" defaultValue={fair.creator} ref="creator" />
            </div>

            <div className="form-group col-sm-6">
               <label>开始时间</label>
               <input type="text" name="begain_at" defaultValue={fair.begain_at.slice(0, 10)} onFocus={this.handleFocus}
                      id="begain_at" className="form-control" required  ref="begain_at" />
            </div>

            <div className="form-group col-sm-6">
               <label>结束时间</label>
               <input type="text"  name="end_at" defaultValue={fair.end_at.slice(0, 10)} onFocus={this.handleFocus}
                      id="end_at" className="form-control" required ref="end_at" />
            </div>

            <div className="form-group">
               <label>专场介绍</label>
               <textarea className="form-control" name="intro" rows="5" defaultValue={fair.intro}
                                required ref="intro" />
            </div>

            <div className="form-group">
               <label>修改图片</label>
               <input type="file" className="form-control preview-img" onChange={this.handleChange}
                      style={this.state.divStyle} name="banner" ref="banner" />
            </div>

            <FairEditRadio handleRadio={this.handleRadio} status={fair.status} />

            <input className="hidden" name="id" defaultValue={fair.id} ref="id" />
            <button type="button" className="btn btn-secondary"
                    onClick={this.props.dad.handleClick} name="edit_display" value="false" >取消</button>

            <button type="submit" className="btn btn-success">提交</button>
          </form>
        </div>
      </div>
    )
  }
})


/********** 状态Radio ************/
var FairEditRadio = React.createClass({
  render: function() {
    let defaultStatus = this.props.status

    return (
      <span>
        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} defaultChecked={defaultStatus == "processing"}
               name="status" type="radio" defaultValue="processing" />发布
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} defaultChecked={defaultStatus == "pause"}
               name="status" type="radio" defaultValue="pause" />暂停专场
        </label>

        <label className="checkbox-inline">
        <input onChange={this.props.handleRadio} defaultChecked={defaultStatus == "end"}
               name="status" type="radio" defaultValue="end" />结束专场
        </label>
      </span>
    )
  }
});
