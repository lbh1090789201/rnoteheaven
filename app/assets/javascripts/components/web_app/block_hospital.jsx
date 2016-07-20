var BlockHospital = React.createClass({
  getInitialState: function() {
    return {
      hospitals: [],
      input_value: '',
      input_id: '',
    }
  }
  ,handleChange: function(e) {
      console.log(this.state.input_id)
    var hospital_name = e.target.value

    this.setState({
      input_value: hospital_name,
      input_id: '',
    })

    if(e.target.value) {
      $.ajax({
        url: '/webapp/block_hospitals/new',
        type: 'GET',
        data: {'hospital_name': hospital_name},
        success: function(data) {
          this.setState({
            hospitals: data.hospitals
          })
        }.bind(this),
        error: function(data){
          console.log(data.responseText)
        },
      })

    }
  }
  ,handleClick: function(e) {
    let hospital_name = e.target.id
        hospital_id = e.target.value
        console.log(e.target)
    this.setState({
      input_value: hospital_name,
      input_id: hospital_id,
    })

  }
  ,handleSubmit: function(e) {
    console.log(this.state.input_id)
    if(this.state.input_id) {
      $.ajax({
        url: '/webapp/block_hospitals',
        type: 'POST',
        data: {'hospital_name': this.state.input_value, 'hospital_id': this.state.input_id,},
        success: function(data) {
          console.log('ok')
        }.bind(this),
        error: function(data){
          console.log(data.responseText)
        },
      })
    } else {
      // FailMask('.container','请点击搜索结果后，再提交')
      FailMask('.container','无此机构')
    }
  }
  ,render: function() {
    return (
      <div className="block-shield">
        <form action="" method="post" data-remote="true" className="block-form" >
          <input className="edit-text" type="text" name="text" placeholder="请输入机构名称"
                 index={this.state.input_id} value={this.state.input_value} onChange={this.handleChange}/>
        </form>
      <ul>
        {
          this.state.hospitals.map(
            hospital =>

            <li key={hospital.id} id={hospital.name} value={hospital.id}
                className="hospital_li" onClick={this.handleClick}>{hospital.name} </li>
          )
        }
      </ul>
      <button id="btn_sub" onClick={this.handleSubmit} className="btn btn-info btn-right">点击提交</button>
      </div>
    )
  }
})
