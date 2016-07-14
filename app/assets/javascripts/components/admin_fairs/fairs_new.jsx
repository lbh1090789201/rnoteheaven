var FairNew = React.createClass({
  getInitialState: function() {
    return {
      divStyle: {
        backgroundImage: '',
      }
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
    let banner_file = this.refs.banner.files[0],
        formData = new FormData(e.target)

    $.ajax({
      url: '/admin/fairs',
      type: 'POST',
      data: formData,
      contentType: false,
      processData: false,
      success: function(data){
        let  fairs = this.props.dad.state.fairs

        fairs.push(data.fair)
        this.props.dad.setState({
           fairs: fairs,
           new_display: false
        })
      }.bind(this),
      error: function(data){
        alert(data.responseText)
        this.props.dad.setState({
            new_display: false,
        })
      }
    })
  }
  ,render: function() {
    return (
      <div className="mask-user">
        <div className="user-box">
          <form method="post" action="/admin/fairs" encType="multipart/form-data" onSubmit={this.handleSubmit}>
            <div className="form-group col-sm-6">
               <label>用户名称</label>
               <input className="form-control" placeholder="专场名称" name="name"
                             pattern=".{1,}" required title="专场名称不能为空" ref="name" />
            </div>

            <div className="form-group col-sm-6">
               <label>发布人</label>
               <input type="text" className="form-control" name="creator"
                           pattern=".{1,}" required title="发布人不能为空" ref="creator" />
            </div>

            <div className="form-group col-sm-6">
               <label>开始时间</label>
               <input type="date" className="form-control" name="begain_at"
                               pattern=".{1,}" required title="开始时间不能为空" ref="begain_at" />
            </div>

            <div className="form-group col-sm-6">
               <label>结束时间</label>
               <input type="date" className="form-control" name="end_at"
                               pattern=".{1,}" required title="结束时间不能为空" ref="end_at" />
            </div>

            <div className="form-group col-sm-12">
               <label>专场介绍</label>
               <textarea className="form-control col-sm-12" name="intro" rows="5"
                               pattern=".{6,}" required title="最少6个字符" ref="intro" />
            </div>

            <div className="form-group col-sm-12">
               <label>上传图片</label>
               <input type="file" className="form-control preview-img" onChange={this.handleChange}
                      style={this.state.divStyle} name="banner" ref="banner" />
            </div>

            <input className="hidden" name="status" defaultValue="processing" />

            <button type="button" className="btn btn-secondary"
                    onClick={this.props.dad.handleClick} name="new_display" value="false" >取消</button>

            <button type="submit" className="btn btn-success">提交</button>
          </form>
        </div>
      </div>
    )
  }
})
