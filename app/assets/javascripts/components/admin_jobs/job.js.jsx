var Job = React.createClass({
  render: function() {
    return (
      <tr>
        <td>{this.props.index + 1}</td>
        <td>{this.props.data.name}</td>
        <td>{this.props.data.job_type}</td>
        <td>行业</td>
        <td>发布机构</td>
        <td>{this.props.data.submit_at ? this.props.data.submit_at.slice(0,10) : '----'}</td>
        <td>{this.props.data.status}</td>
        <td>查看</td>
        <td><input onChange={this.props.handleCheck} type="checkBox" value={this.props.data.id} /></td>
      </tr>
    )
  }
});
