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
    [Table("TreeNSI_Addr_AddressNationalData")]
    [DefaultClassOptions]
    public class AddressNationalData
    {
        [Column(Order = 0), Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdAddress { get; set; }
        [Column(Order = 1), Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdLanguage { get; set; }
        [FieldSize(100)]
        [StringLength(100)]
        public String ATUAddress { get; set; }
        [FieldSize(100)]
        [StringLength(100)]
        public String ExtraInfo { get; set; }

        [NotMapped]
        public virtual String aName
        {
            get
            {
                return String.Format("({0}) {1}{2}",
                    (NationalLanguage == null) ? "" :NationalLanguage.LanguageTag.Trim(),
                    (String.IsNullOrWhiteSpace(this.ATUAddress)) ? "" : this.ATUAddress.Trim(),
                    (String.IsNullOrWhiteSpace(this.ExtraInfo)) ? "" : String.Format(", {0}", this.ExtraInfo.Trim()));
            }
        }


        [ForeignKey("IdLanguage")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual NationalLanguage NationalLanguage { get; set; }
        [ForeignKey("IdAddress")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual BusinessObjects.Address Address { get; set; }
    }
}
