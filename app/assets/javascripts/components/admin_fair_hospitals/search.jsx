var FairHospitalSearch = React.createClass({
  getInitialState: function() {
    return {
      golds: [],
      fair: this.props.dad.state.fair,
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
          <SearchForm dad={this}/>
          <SearchTable golds={this.state.golds} dad={this} />
        </div>
      </div>
    )
  }
})


/*********** 搜索表格 ************/
var SearchForm = React.createClass({
  getInitialState: function() {
    return {
      status: '',
      fair_id: this.props.dad.state.fair.id
    }
  }
  ,handleRadio: function(e) {
    this.setState({
      status: e.target.value
    })
  }
  ,handleSubmit: function(e) {
    e.preventDefault()

    let formData = new FormData(e.target)

    formData.append('search', true)
    $.ajax({
      url: '/admin/fairs/' + fair_id + '/fair_hospitals',
      type: 'GET',
      data: formData,
      success: function(data) {
        this.props.dad.setState({
          fairs: data.golds
        })
      }.bind(this),
      error: function(data) {
        alert('查询失败。')
      }
    })
  }
  ,render: function() {
    return (
      <form className='form-inline' onSubmit={this.handleSubmit}>
          <div className='form-group col-sm-3'>
            <input type="text" className="form-control" placeholder='机构帐号' name='id'
                   onChange={this.handleSubmit} ref="id" />
          </div>
          <div className='form-group col-sm-3'>
            <input type="text" className="form-control" placeholder='机构名称' name='name'
                   onChange={this.handleSubmit} ref="name" />
          </div>
          <div className='form-group col-sm-3'>
            <input type="text" className="form-control" placeholder='负责人' name='contact_person'
                   onChange={this.handleSubmit} ref="contact_person" />
          </div>
          <button type='submit' className='btn btn-primary'>查询</button>
     </form>
    )
  }
})


/*********** 搜索结果列表 ***********/
var SearchTable = React.createClass({
  getInitialState: function() {
    return {

    }
  }
  ,render: function() {
    return (
      <table className="table table-bordered">
        <SearchTableHead />
        <SearchTableContent golds={this.props.golds} dad={this.props.dad} />
      </table>
    )
  }
})

var SearchTableHead = React.createClass({
  render: function() {
    return (
      <thead>
        <tr>
          <th>序号</th>
          <th>帐号</th>
          <th>机构名称</th>
          <th>负责人</th>
          <th>操作</th>
        </tr>
      </thead>
    )
  }
})

var SearchTableContent = React.createClass({
  render: function() {
    return (
      <tbody>
        {
          this.props.golds.map(
            function(gold, index) {
              return (<SearchItem key={gold.id} gold={gold} index={index} dad={this.props.dad} />)
            }.bind(this)
          )
        }
      </tbody>
    )
  }
})

var SearchItem = React.createClass({
  clickEdit: function() {
    this.props.dad.setState({
      gold: this.props.gold,
      index: this.props.index,
      edit_display: true
    })
  }
  ,render: function() {
    let gold = this.props.gold,
        index = this.props.index + 1

    return (
      <tr>
        <td>{index}</td>
        <td>{gold.id}</td>
        <td>{gold.name}</td>
        <td>{gold.contact_person}</td>
        <td><button onClick={this.clickEdit} className="btn btn-default btn-form">添加</button></td>
      </tr>
    )
  }
})
