using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Validation;
using DevExpress.Persistent.Base.General;
using DevExpress.Persistent.Base;
using System.Data.Entity.ModelConfiguration;
using DevExpress.ExpressApp;

namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_CounteragentAddressExtraInfo")]
    [DefaultClassOptions]
    [DefaultProperty("ExtraInfo")]
    public class CounteragentAddressExtraInfo
    {
        [ForeignKey("CounteragentAddress")]
        [Key]
        public Int32 IdCountragentAddress { get; set; }
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual CounteragentAddress CounteragentAddress { get; set; }
        [StringLength(300)]
        public string ExtraInfo { get; set; }

        
    }
}
