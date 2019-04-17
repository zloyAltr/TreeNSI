using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;
using DevExpress.Persistent.Validation;

namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_RailwayCompanyTranslitName")]
    public class RailwayCompanyTranslitName
    {
        [Key, ForeignKey("RailwayCompany")]
        public Int32 IdRailwayCompany { get; protected set; }
        [FieldSize(50)]
        [StringLength(50)]
        public String ShortName { get; set; }
        [FieldSize(250)]
        [StringLength(250)]
        public String FullName { get; set; }

        [RuleRequiredField(DefaultContexts.Save)]
        public virtual RailwayCompany RailwayCompany { get; set; }

    }
}
