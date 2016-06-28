var ReviewJob = React.createClass({
  valid: function() {
    // return(this.props.title && this.props.date && this.props.amount);
  }
  ,render: function() {
    console.log(this)
    return (
      <form className='form-inline' onSubmit={this.handleSubmit}>
        <div className='form-group col-sm-4'>
            <input type="text" className="form-control" placeholder='开始时间' name='time_after'
                   value={this.props.search["time_after"]} onChange={this.handleChange} />
          </div>
          <div className='form-group col-sm-4'>
            <input type="text" className="form-control" placeholder='结束时间' name='title'
                   value={this.props.search["time_before"]} onChange={this.handleChange} />
          </div>
          <div className='form-group col-sm-4'>
            <input type='text' className='form-control' placeholder='工作类型' name='amount'
                   value={this.props.search["job_type"]} onChange={this.handleChange} />
          </div>
          <button type='submit' className='btn btn-primary' disabled={!this.valid()}>查询</button>
     </form>
    )
  }
})
