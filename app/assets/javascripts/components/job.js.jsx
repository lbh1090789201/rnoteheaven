var Job = React.createClass({
  handleCheck: function(){

  }
  ,render: function() {
    console.log(this.props)
    return (
      <tr>
        <td>{this.props.data.id}</td>
        <td>{this.props.data.name}</td>
        <td>{this.props.data.job_type}</td>
        <td>行业</td>
        <td>发布机构</td>
        <td>{this.props.data.created_at.slice(0,9)}</td>
        <td>{this.props.data.release_at.slice(0,9)}</td>
        <td>{this.props.data.status}</td>
        <td>查看</td>
        <td><input onChange={this.props.handleCheck} name="goodCheckbox" type="checkBox" value="A" /></td>
      </tr>
    )
  }
});
