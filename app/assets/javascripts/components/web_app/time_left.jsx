var TimeLeft = React.createClass({
  getInitialState: function() {
    return {
      init_time: this.props.time,
      time: '',
    }
  }
  ,componentDidMount: function() {
    this.autoChange()
  }
  ,autoChange: function() {
    let time_left = this.state.init_time,
        _self = this,
        hours = 0,
        minutes = 0,
        seconds = 0,
        res = ''

    hours = Math.floor(time_left / 3600)
    time_left -= hours * 3600
    minutes = Math.floor(time_left / 60)
    seconds = time_left - minutes * 60

    res = `${hours}:${("0" + minutes).slice(-2)}:${("0" + seconds).slice(-2)}`

    this.setState({
      init_time : this.state.init_time - 1,
      time: res,
    })

    setTimeout(function() {
       _self.autoChange();
    }, 1000)
  }
  ,render: function() {
    return (
      <p className="left-time">
        {this.state.time}
      </p>
    )
  }
})
