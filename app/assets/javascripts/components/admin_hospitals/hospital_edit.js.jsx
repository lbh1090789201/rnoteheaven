var AdminEditHospital = React.createClass({
  getInitialState: function() {
    return {
      hospital: this.props.data,
      hos_info: this.props.dad.state.hos_info,
    }
  }
  ,render: function() {
    return (
      <div className="mask-user">
        <div className="user-box">
          <form onSubmit={this.handleSubmit}>
            <div className="form-group">
               <label>申请机构</label>
                 <input className="form-control" type="text" placeholder="机构名称"
                    name="hospital_name" required ref="hospital_name" defaultValue={this.state.hospital.hospital_name}  />
            </div>

            <div className="form-group">
               <label>行业</label>
                 <input type="text" className="form-control" placeholder="行业" name="industry"
                               required ref="industry" defaultValue={this.state.hospital.industry} />
            </div>

            <div className="form-group">
               <label>性质</label>
                 <input type="text" className="form-control" placeholder="性质" name="property"
                               required ref="property" defaultValue={this.state.hospital.property} />
            </div>

            <div className="form-group">
               <label>规模</label>
                 <input type="text" className="form-control" placeholder="规模" name="scale"
                            required ref="scale" defaultValue={this.state.hospital.scale} />
            </div>

            <div className="form-group">
               <label>地区</label>
                 <input type="text" className="form-control" placeholder="地区" name="region"
                           required ref="region" defaultValue={this.state.hospital.region} />
            </div>

            <div className="form-group">
               <label>机构地址</label>
                 <input type="text" className="form-control" placeholder="机构地址" name="location"
                           required ref="location" defaultValue={this.state.hospital.location} />
            </div>

            <div className="form-group">
               <label>账号</label>
                 <input type="text" className="form-control" placeholder="账号" name="id"
                          required ref="id" defaultValue={this.state.hospital.id} />
            </div>

            <div className="form-group">
               <label>姓名</label>
                 <input type="text" className="form-control" placeholder="姓名" name="id"
                          required ref="id" defaultValue={this.state.hospital.id} />
            </div>

            <div className="form-group">
               <label>手机号码</label>
                 <input type="text" className="form-control" placeholder="手机号码" name="id"
                          required ref="id" defaultValue={this.state.hospital.id} />
            </div>

            <div className="form-group">
               <label>机构介绍</label>
                 <input type="text" className="form-control" placeholder="机构介绍" name="introduction"
                          required ref="introduction" defaultValue={this.state.hospital.introduction} />
            </div>

            <div className="form-group">
               <label>级别配置</label>
            </div>

            <button type="button" className="btn btn-secondary" onClick={this.handleClick}>取消</button>
            <button type="submit" className="btn btn-success">提交</button>
          </form>
        </div>
      </div>
    )
  }
})
