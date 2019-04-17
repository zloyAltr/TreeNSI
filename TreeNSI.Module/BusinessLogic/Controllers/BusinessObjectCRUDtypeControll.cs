using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TreeNSI.Module.BusinessObjects;

namespace TreeNSI.Module.BusinessLogic.Controllers
{
    public class BusinessObjectCRUDtypeControll
    {
        private bool isDefaultCRUD = true;
        public BusinessObjectCRUDtypeControll(object instance)
        {
            isDefaultCRUD = false;
        }

        public BusinessObjectCRUDtypeControll()
        {
            isDefaultCRUD = false;
        }

        public bool IsDefaultCRUD()
        {
            return isDefaultCRUD;
        }

        public void CheckInstance(object instance)
        {
            isDefaultCRUD = false; //здесь проверка на интерфейсы
        }

        public void GenerateException()
        {
            throw new Exception("Ошибка записи");
        }
            
    }
}
