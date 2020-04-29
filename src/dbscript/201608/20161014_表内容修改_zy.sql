--流程字段修改
UPDATE wf_node_trans SET transname = '拟同意处罚' WHERE transname = '拟处罚';

UPDATE wf_node_trans SET transname = '拟处罚：送达《行政处罚事先告知书》' WHERE transname = '你处罚：送达《行政处罚事先告知书》';
--附件必填项修改
UPDATE pfjcs SET FJCSFJBC = '0' WHERE FJCSFJBC = '1';