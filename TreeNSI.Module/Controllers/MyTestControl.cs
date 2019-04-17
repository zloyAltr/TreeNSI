using System;
using System.Collections;
using DevExpress.ExpressApp;
using DevExpress.ExpressApp.Actions;
using DevExpress.ExpressApp.Editors;
using TreeNSI.Module.BusinessObjects;

namespace TreeNSI.Module.Controllers
{
    public partial class MyTestControl : ViewController
    {
        public MyTestControl()
        {
            InitializeComponent();
            RegisterActions(components);
        }
    }
}
