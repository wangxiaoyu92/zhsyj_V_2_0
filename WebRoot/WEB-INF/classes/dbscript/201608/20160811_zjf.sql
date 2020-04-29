--修改工作流相关表的主键为varchar类型
alter table wf_node modify  wfnodeid varchar(32); 
alter table wf_node modify  nodeid varchar(32); 

alter table wf_node_role modify  noderoleid varchar(32); 
alter table wf_node_role modify  nodeid varchar(32); 
alter table wf_node_role modify  roleid varchar(32);

alter table wf_node_trans modify  nodetransid varchar(32); 
alter table wf_node_trans modify  transid varchar(32); 
alter table wf_node_trans modify  transfrom varchar(32);
alter table wf_node_trans modify  transto varchar(32);

alter table wf_process modify  psid varchar(32); 
alter table wf_process modify  aae011 varchar(32);

alter table wf_workday modify  wdid varchar(32); 

alter table wf_yewu_process modify  yewuprocessid varchar(32); 

alter table wf_ywlc modify  ywlcid varchar(32); 
alter table wf_ywlc modify  ywlccurnode varchar(32);
alter table wf_ywlc modify  aae011 varchar(32);

alter table wf_ywlclog modify  ywlclogid varchar(32); 
alter table wf_ywlclog modify  nodeid varchar(32);
alter table wf_ywlclog modify  aae011 varchar(32);

alter table zfajzfwsnode modify  nodeid varchar(32);
