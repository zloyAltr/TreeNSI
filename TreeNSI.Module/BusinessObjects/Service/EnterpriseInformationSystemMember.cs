using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;
using DevExpress.Persistent.Validation;
using DevExpress.ExpressApp;


namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_EnterpriseInformationSystemMember")]
    [DefaultClassOptions]
    public class EnterpriseInformationSystemMember
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdEISMember { get; protected set; }
        [Required]
        [FieldSize(100)]
        [StringLength(100)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string EISMemberName { get; set; }
        [Required]
        [FieldSize(120)]
        [StringLength(100)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string HandbookName { get; set; }
        [FieldSize(300)]
        [StringLength(300)]
        public string Source { get; set; }
        [FieldSize(70)]
        [StringLength(70)]
        public string KeyColumnName { get; set; }
        [FieldSize(15)]
        [StringLength(15)]
        public string KeyColumnType { get; set; }
        public Int32? IdDirectoryType { get; set; }

        [ForeignKey("IdDirectoryType")]
        public virtual DirectoryType DirectoryType { get; set; }

    }
}
