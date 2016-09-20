var FairNew = React.createClass({
  getInitialState: function() {
    return {
      divStyle: {
        backgroundImage: '',
      }
    }
  }
  ,componentDidMount: function() {
    formFair('#form_fair_new')

    $('.preview-img').on('click', function(){
      $(".upload-file").trigger('click')
    })
  }
  ,handleChange: function(e) {
    let url = URL.createObjectURL(e.target.files[0])

    $('.preview-img').css('background-image', 'url(' + url + ')')

    myInfo('图片上传成功！', 'success')
  }
  ,handleFocus: function(e) {
      let id = e.target.id
      myDatePicker(id, 'begain_at', 'end_at')
    }
  ,handleSubmit: function(e) {
    e.preventDefault()
    if(invalid('#form_fair_new')) return // 不合法就返回

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

        myInfo('专场发布成功！', 'success')
      }.bind(this),
      error: function(data){
        var info = JSON.parse(data.responseText)
        myInfo(info["info"], 'fail')
      }
    })
  }
  ,render: function() {
    return (
      <div className="mask-user">
        <div className="user-box">
          <form method="post" action="/admin/fairs" encType="multipart/form-data"
                id="form_fair_new" onSubmit={this.handleSubmit}>
            <div className="form-group col-sm-6">
               <label>专场名称</label>
               <input className="form-control" placeholder="专场名称" name="name"
                       ref="name" />
            </div>

            <div className="form-group col-sm-6">
               <label>发布人</label>
               <input type="text" className="form-control" name="creator" ref="creator" />
            </div>

            <div className="form-group col-sm-6">
               <label>开始时间</label>
               <input type="text" id="begain_at" className="form-control" name="begain_at" placeholder="开始时间"
                              onFocus={this.handleFocus} pattern=".{1,}" required  ref="begain_at" />
            </div>

            <div className="form-group col-sm-6">
               <label>结束时间</label>
               <input type="text" id="end_at" className="form-control" name="end_at" placeholder="结束时间"
                              onFocus={this.handleFocus} pattern=".{1,}" required ref="end_at" />
            </div>

            <div className="form-group col-sm-12">
               <label>专场介绍</label>
               <textarea className="form-control col-sm-12" name="intro" rows="5"
                         required ref="intro" />
            </div>

            <div className="form-group col-sm-12">
               <label>上传图片</label>
               <input type="file" style={{'display':'none'}} className="form-control upload-file" onChange={this.handleChange}
                      required name="banner" ref="banner" />
               <div className="preview-img"></div>
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
