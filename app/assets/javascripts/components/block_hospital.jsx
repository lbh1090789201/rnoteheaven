var BlockHospital = React.createClass({
  getInitialState: function() {
    return {
      hospitals: [],
      input_value: '',
      input_id: '',
    }
  }
  ,handleChange: function(e) {
    var hospital_name = e.target.value

    this.setState({
      input_value: hospital_name,
    })

    $.ajax({
      url: '/webapp/block_hospitals/new',
      type: 'GET',
      data: {'hospital_name': hospital_name},
      success: function(data) {
        // console.log(data)
        this.setState({
          hospitals: data.hospitals
        })


      }.bind(this),
      error: function(data){
        alert(data.responseText)
      },
    })
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
    $.ajax({
      url: '/webapp/block_hospitals',
      type: 'POST',
      data: {'hospital_name': this.state.input_value},
      success: function(data) {
        console.log('ok')
      }.bind(this),
      error: function(data){
        alert(data.responseText)
      },
    })
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
      <button id="btn_sub" onClick={this.handleSubmit} style={{display: 'none'}}>点击提交</button>
      </div>
    )
  }
})
