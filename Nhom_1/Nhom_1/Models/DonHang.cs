namespace Nhom_1.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DonHang")]
    public partial class DonHang
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DonHang()
        {
            ChiTietDHs = new HashSet<ChiTietDH>();
        }

        public DonHang(int ma_TK, DateTime? ngayDat_DH, int? trangThai_DH, string dienThoai_DH, string hoTen_DH, string email_DH, string diaChi_DH, string ghiChu_DH)
        {
            Ma_TK = ma_TK;
            NgayDat_DH = ngayDat_DH;
            TrangThai_DH = trangThai_DH;
            DienThoai_DH = dienThoai_DH;
            HoTen_DH = hoTen_DH;
            Email_DH = email_DH;
            DiaChi_DH = diaChi_DH;
            GhiChu_DH = ghiChu_DH;
        }

        [Key]
        public int Ma_DH { get; set; }

        public int Ma_TK { get; set; }

        public DateTime? NgayDat_DH { get; set; }

        public int? TrangThai_DH { get; set; }

        [StringLength(15)]
        public string DienThoai_DH { get; set; }

        [StringLength(50)]
        public string HoTen_DH { get; set; }

        [StringLength(30)]
        public string Email_DH { get; set; }

        [StringLength(150)]
        public string DiaChi_DH { get; set; }

        [StringLength(500)]
        public string GhiChu_DH { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChiTietDH> ChiTietDHs { get; set; }

        public virtual TaiKhoan TaiKhoan { get; set; }
    }
}
