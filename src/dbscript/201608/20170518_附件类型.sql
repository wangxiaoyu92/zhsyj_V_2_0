-- aa10表 附件类型 FJTYPE
-- 设置aaa105字段为该类型附件上传属性 1 ： 只能上传一张 0 ： 可上传多张

-- 首先全部设置为只能上传一张
UPDATE aa10 SET AAA105 = '1' WHERE aaa100 = 'fjtype';
-- 设置 图片、文档、视频、商品图片、检测合格证明 类型附件可以上传多张
UPDATE aa10 SET AAA105 = '0' WHERE aaa100 = 'fjtype' AND AAA102 in ('1', '2', '3', '8', '9');




