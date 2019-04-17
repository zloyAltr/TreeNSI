using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;
using DevExpress.Persistent.Validation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DevExpress.Persistent.BaseImpl.EF.PermissionPolicy;

namespace TreeNSI.Module.BusinessObjects
{
    [DefaultClassOptions]
    public class User : PermissionPolicyUser
    {
        public User() : base()
        {

        }

        [Required]
        [FieldSize(50)]
        [StringLength(50)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string FIO { get; set; }

        [FieldSize(38)]
        [StringLength(38)]
        [Browsable(false)]
        public string IdEmploy { get; set; }

        [ForeignKey("IdEmploy")]
        public virtual vEmployee Employee { get; set; }
    }
}
