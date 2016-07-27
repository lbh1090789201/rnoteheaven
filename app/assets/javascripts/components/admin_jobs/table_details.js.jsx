var Job = React.createClass({
  handleClick: function(e) {
    this.props.dad.setState ({
      view_display: true,
      jid: e.target.id,
    })
  }
  ,render: function() {
    // console.log(this.props.dad.state.jid)
    return (
      <tr>
        <td>{this.props.index + 1}</td>
        <td>{this.props.data.name}</td>
        <td>{this.props.data.job_type}</td>
        <td>{this.props.data.hospital_industry}</td>
        <td>{this.props.data.hospital_name}</td>
        <td>{this.props.data.submit_at ? this.props.data.submit_at.slice(0,10) : '----'}</td>
        <td>{this.props.data.status}</td>
        <td><button onClick={this.handleClick} className="btn btn-default btn-form" id={this.props.data.id}>查看</button></td>
        <td><input onChange={this.props.handleCheck} type="checkBox" value={this.props.data.id} /></td>
      </tr>
    )
  }
});
