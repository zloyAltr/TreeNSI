using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DevExpress.ExpressApp.SystemModule;
using DevExpress.Persistent.BaseImpl;
using DevExpress.ExpressApp;
using TreeNSI.Module.BusinessObjects;
using DevExpress.ExpressApp.Actions;
using System.ComponentModel;

namespace TreeNSI.Module.Controllers
{
    public class TreeNSI_EditModelController : ViewController
    {
        protected override void OnActivated()
        {
            base.OnActivated();
            NewObjectViewController controller = Frame.GetController<NewObjectViewController>();
            
            View _view = controller.View;

            var _object = _view.CurrentObject;
            if (LastModel.lastActiveObject == null)
                LastModel.lastActiveObject = new List<object>();
            if (_object != null)
            {
                INewItem _needForSetData = _object as INewItem;
                if (_needForSetData != null)
                    _needForSetData.NewItem();
                if (!LastModel.lastActiveObject.Contains(_object))
                    LastModel.lastActiveObject.Add(_object);
            }
        }

       

         

        protected override void OnDeactivated()
        {
            
            base.OnDeactivated();
            var _object = View.CurrentObject;
            if (LastModel.lastActiveObject != null && _object != null)
                if (LastModel.lastActiveObject.Contains(_object))
                    LastModel.lastActiveObject.Remove(_object);
        }
    }
}
