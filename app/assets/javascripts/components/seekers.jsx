var Seeker = React.createClass({
  getInitialState: function() {
    return {
      res: '……'
    }
  }
  ,handleClick: function(e) {
    e.preventDefault()
    console.log(e.target.value)
    var candidate = {
      session: "28920160606162521",
      seq: 0,
      userId: 289,
      target: 'candidate'
    },
    recruit = {
      session: "28820160629153437",
      seq: 0,
      userId: 288,
      target: 'recruit'
    }
    if(e.target.value == "candidate") {
      var upload_data = candidate
    } else if (e.target.value == "recruit") {
      var upload_data = recruit
    } else {
      return
    }

    $.ajax({
      url: '/api/v1/connect_app/login_app',
      type: 'POST',
      data: upload_data,
      /*{
        session: "28920160606162521",
        seq: 0,
        userId: 289,
        target: 'candidate'
      },
      data: {
        session: "28820160629153437",
        seq: 0,
        userId: 288,
        target: 'recruit'
      },*/
      success: function(data) {
        console.log(data)
        window.location = data["url"]
        // this.setState({res: data.res + data.user_info})
      }.bind(this),
      error: function(data) {
        console.log(data)
        this.setState({
          res: data
        })
      }
    })
  }
  ,bandleChange: function(){

  }
  ,render: function() {
    return (
      <div style={{"marginTop": "3rem"}}>
        <button onClick={this.handleClick} className="btn btn-primary"
                value="candidate" style={{"position": "relative"}}>医生API</button>
        <button onClick={this.handleClick} className="btn btn-info"
                value="recruit" style={{"position": "relative"}}>医院API</button>
        {/*<textarea value={this.state.res} onChange={this.bandleChange} className="form-control"></textarea>*/}
      </div>
    )
  }
})
