using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DevExpress.ExpressApp.Actions;
using TreeNSI.Module.BusinessObjects;

namespace TreeNSI.Module.Controllers
{
    public class TreeNSI_DeleteController : DevExpress.ExpressApp.SystemModule.DeleteObjectsViewController
    {
        protected override void Delete(SimpleActionExecuteEventArgs args)
        {
            //окно с предупреждением уже прошло
            //здесь будет проверка на возможность удаления объекта
            //если элемент нужно снять с регистрации, то это лучше сделать здесь

            
            int _idTypeDirectory = 0;
            int _idCataloge = 0;

            IRegistrationObject _regObject = args.CurrentObject as IRegistrationObject;
            if(_regObject != null)
            {
                _idTypeDirectory = _regObject.GetIdTypeDirectory();
                _idCataloge = _regObject.GetIdCatalog();
            }


            base.Delete(args);

            if (_idTypeDirectory > 0 && _idCataloge > 0)
                if (!DbMethods.UnRegistration(
                    _idTypeDirectory,
                    _idCataloge
                    ))
                    return;
            
        }
    }
}
