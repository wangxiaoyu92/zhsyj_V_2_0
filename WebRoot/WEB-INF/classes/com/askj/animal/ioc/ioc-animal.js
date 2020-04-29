/**
 * 动物管理配置
 */
var ioc = {
    /***************动物管理************************/
    animalModule : {
        type : "com.askj.animal.module.AnimalModule",
        fields : {
            animalService : {
                refer : 'animalService'
            }
        }
    },
    animalService : {
        type : "com.askj.animal.service.AnimalService",
        fields : {
            dao : {
                refer : 'dao'
            }
        }

    }
}