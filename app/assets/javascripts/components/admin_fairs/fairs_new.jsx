var FairNew = React.createClass({
  getInitialState: function() {
    return {
      show_name: '',
      role: '',
      edit_diaplay: '',
      scopes: [],
      checkValues: {"jobs_manager": false, "resumes_manager": false, "hospitals_manager": false,
                 "fairs_manager": false, "vips_manager": false, "acounts_manager": false},
    }
  }
  ,handleChange: function(e) {
    let name = e.target.name

    if(name == "show_name") {
      this.props.user_info.show_name = e.target.value
    } else if(name = "role") {
      this.props.user_info.role = e.target.value
    }

    this.setState({
      [name]: e.target.value
    })
  }
  ,handleCheck: function(e) {
    let scopes = this.state.scopes,
        index = scopes.indexOf(e.target.value)

    if(index == -1) {
      scopes.push(e.target.value)
    } else {
      scopes.splice(index, 1)
    }

    this.setState({scopes: scopes})
  }
  ,handleSubmit: function(e) {
    e.preventDefault()

    let name = this.refs.name.value,
        begin_at = this.refs.begin_at.value,
        end_at = this.refs.end_at.value,
        creator = this.refs.creator.value,
        intro = this.refs.intro.value,
        status = 'processing',
        banner_file = this.refs.banner.files[0]

    console.log(formData)
    $.ajax({
      url: '/admin/fairs',
      type: 'POST',
      data: formData,
      success: function(data){
        console.log(data)
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
          <form method="post" action="/admin/fairs" encType="multipart/form-data" data-remote="true">
            <div className="form-group">
               <label>用户名称</label>
               <input className="form-control" placeholder="专场名称" name="name"
                             pattern=".{1,}" required title="专场名称不能为空" ref="name" />
            </div>
            <div className="form-group">
               <label>开始时间</label>
               <input type="date" className="form-control" name="begin_at"
                               pattern=".{1,}" required title="开始时间不能为空" ref="begin_at" />
            </div>

            <div className="form-group">
               <label>结束时间</label>
               <input type="date" className="form-control" name="end_at"
                               pattern=".{1,}" required title="结束时间不能为空" ref="end_at" />
            </div>

            <div className="form-group">
               <label>发布人</label>
               <input type="text" className="form-control" name="creator"
                           pattern=".{1,}" required title="发布人不能为空" ref="creator" />
            </div>

            <div className="form-group">
               <label>专场介绍</label>
               <textarea className="form-control" name="intro" rows="5"
                               pattern=".{6,}" required title="最少6个字符" ref="intro" />
            </div>

            <div className="form-group">
               <label>上传图片</label>
               <input type="file" className="form-control" name="banner" ref="banner" />
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
