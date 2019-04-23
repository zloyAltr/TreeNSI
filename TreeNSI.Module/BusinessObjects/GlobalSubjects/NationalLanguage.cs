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
    //[NavigationItem("Глобальные сущности")]
    [Table("TreeNSI_NationalLanguage")]
    [DefaultProperty("LanguageTag")]
    public class NationalLanguage
    {
        public NationalLanguage() { }

        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Int32 IdLanguage { get; protected set; }
        [FieldSize(30)]
        [StringLength(30)]
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
        [FieldSize(10)]
        [StringLength(10)]
        public string LanguageTag { get; set; }
    }
}
