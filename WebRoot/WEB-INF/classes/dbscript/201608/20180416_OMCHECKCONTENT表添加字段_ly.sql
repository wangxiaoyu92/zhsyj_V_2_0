ALTER TABLE omcheckcontent
ADD COLUMN contentdesc  varchar(5000) NULL COMMENT '内容详细描述' AFTER contentsortid;

