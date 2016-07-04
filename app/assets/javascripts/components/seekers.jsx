var Seeker = React.createClass({
  getInitialState: function() {
    return {
      res: '……'
    }
  }
  ,handleClick: function(e) {
    $.ajax({
      url: '/api/v1/connect_app/login_app',
      type: 'POST',
      data: {
        session: "28920160606162521",
        seq: 0,
        userId: 289,
        target: 'candidate'
      },
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
      <div>
        <button onClick={this.handleClick} className="btn btn-primary">链接到 App_API</button>
        <textarea value={this.state.res} onChange={this.bandleChange} className="form-control"></textarea>
      </div>
    )
  }
})
