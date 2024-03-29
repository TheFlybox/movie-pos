/****** Object:  Database [Prime]    Script Date: 19/07/05 14:43:15 ******/
CREATE DATABASE [Prime]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Prime', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Prime.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Prime_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Prime_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Prime] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Prime].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Prime] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Prime] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Prime] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Prime] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Prime] SET ARITHABORT OFF 
GO
ALTER DATABASE [Prime] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Prime] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Prime] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Prime] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Prime] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Prime] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Prime] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Prime] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Prime] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Prime] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Prime] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Prime] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Prime] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Prime] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Prime] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Prime] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Prime] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Prime] SET RECOVERY FULL 
GO
ALTER DATABASE [Prime] SET  MULTI_USER 
GO
ALTER DATABASE [Prime] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Prime] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Prime] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Prime] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Prime] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Prime', N'ON'
GO
ALTER DATABASE [Prime] SET QUERY_STORE = OFF
GO
/****** Object:  Table [dbo].[Category]    Script Date: 19/07/05 14:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[IdCategory] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NULL,
	[Description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 19/07/05 14:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[IdProduct] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NULL,
	[Description] [varchar](255) NULL,
	[IdCategory] [int] NULL,
	[Price] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 19/07/05 14:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock](
	[IdStock] [int] IDENTITY(1,1) NOT NULL,
	[IdProduct] [int] NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdStock] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_Product]    Script Date: 19/07/05 14:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VW_Product]
as
select
	P.IdProduct,
	P.Name,
	P.Description,
	C.Name [Category],
	P.Price,
	Stock = (
		select
			Quantity
		from Stock
		where IdProduct = P.IdProduct
	)
from Product P
inner join Category C on P.IdCategory = C.IdCategory;
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 19/07/05 14:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[IdCustomer] [int] IDENTITY(1,1) NOT NULL,
	[DNI] [varchar](13) NULL,
	[Firstname] [varchar](255) NULL,
	[Lastname] [varchar](255) NULL,
	[Address] [varchar](255) NULL,
	[Gender] [char](1) NULL,
	[Phone] [varchar](24) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCustomer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RentStatus]    Script Date: 19/07/05 14:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentStatus](
	[IdRentStatus] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NULL,
	[Description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRentStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rent]    Script Date: 19/07/05 14:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rent](
	[IdRent] [int] IDENTITY(1,1) NOT NULL,
	[IdCustomer] [int] NULL,
	[IdRentStatus] [int] NULL,
	[Date] [date] NULL,
	[ReturnDate] [date] NULL,
	[DueAmount] [money] NULL,
	[DiscountAmount] [money] NULL,
	[TaxAmount] [money] NULL,
	[TotalAmount] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_Rents]    Script Date: 19/07/05 14:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VW_Rents]
as
select
	R.IdRent,
	CONCAT(C.Firstname, ' ', C.Lastname) [Customer],
	R.Date,
	R.ReturnDate,
	RS.Name [Status],
	R.DueAmount,
	R.TotalAmount
from Rent R
inner join RentStatus RS on R.IdRentStatus = RS.IdRentStatus
inner join Customer C on R.IdCustomer = C.IdCustomer;
GO
/****** Object:  Table [dbo].[RentConfig]    Script Date: 19/07/05 14:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentConfig](
	[IdRentConfig] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NULL,
	[Value] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRentConfig] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RentDetail]    Script Date: 19/07/05 14:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentDetail](
	[IdRentDetail] [int] IDENTITY(1,1) NOT NULL,
	[IdRent] [int] NULL,
	[IdProduct] [int] NULL,
	[Quantity] [int] NULL,
	[Price] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRentDetail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RentPayment]    Script Date: 19/07/05 14:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentPayment](
	[IdRentPayment] [int] IDENTITY(1,1) NOT NULL,
	[IdRent] [int] NULL,
	[Amount] [money] NULL,
	[Date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRentPayment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([IdCategory], [Name], [Description]) VALUES (1, N'MOVIE', N'sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus')
INSERT [dbo].[Category] ([IdCategory], [Name], [Description]) VALUES (2, N'VIDEOGAME', N'faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio')
INSERT [dbo].[Category] ([IdCategory], [Name], [Description]) VALUES (3, N'MUSIC', N'ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (1, N'007-6038401-2', N'Myrta', N'Tindle', N'94 Knutson Way', N'F', N'896-866-5881')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (2, N'913-2871746-6', N'Fremont', N'Ivic', N'85 Loomis Court', N'M', N'851-524-9367')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (3, N'576-8771000-5', N'Kai', N'Febry', N'499 Farwell Place', N'F', N'451-786-4165')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (4, N'804-3102634-7', N'Barbabra', N'Camillo', N'735 Annamark Parkway', N'F', N'592-353-8093')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (5, N'845-9574369-9', N'Jesus', N'Natalie', N'8 Claremont Parkway', N'M', N'478-544-8032')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (6, N'666-1530168-7', N'Brynn', N'Chaytor', N'98634 Fairfield Alley', N'F', N'279-146-9270')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (7, N'125-4212045-0', N'Diahann', N'Giggs', N'0 Carioca Alley', N'F', N'488-607-3152')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (8, N'354-8023195-2', N'Andra', N'Geraghty', N'8821 Canary Circle', N'F', N'801-842-9016')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (9, N'966-4157994-1', N'Jaymee', N'Pierton', N'58 Almo Point', N'F', N'197-230-7784')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (10, N'926-0043131-7', N'Hillel', N'Woolmington', N'69292 Anderson Pass', N'M', N'766-809-3905')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (11, N'562-6158779-7', N'Arron', N'Siret', N'1 Ridgeway Avenue', N'M', N'672-545-7548')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (12, N'647-1764139-2', N'Claudetta', N'Chattoe', N'4893 Pepper Wood Avenue', N'F', N'546-963-9523')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (13, N'526-1965072-7', N'Barbey', N'Whettleton', N'2 Chive Plaza', N'F', N'919-635-3608')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (14, N'714-6120474-5', N'Jamey', N'McCoy', N'02 Kim Court', N'M', N'659-487-7922')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (15, N'801-9117718-9', N'Dallon', N'Ewols', N'590 Holy Cross Terrace', N'M', N'438-472-0081')
INSERT [dbo].[Customer] ([IdCustomer], [DNI], [Firstname], [Lastname], [Address], [Gender], [Phone]) VALUES (21, N'991181818', N'Test', N'Testing', N'ASLAKLSLKAKLSKLASLK', N'M', N'34545454')
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (1, N'Generation Um...', N'sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet', 1, 2452.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (2, N'Herbie: Fully Loaded', N'rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui', 2, 2857.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (3, N'Shakiest Gun in the West, The', N'in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem', 1, 3638.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (4, N'Intruder, The', N'sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede', 1, 2169.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (5, N'Intruder, The', N'sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede', 1, 2169.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (6, N'See You Tomorrow, Everyone', N'rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis', 3, 3811.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (7, N'And When Did You Last See Your Father?', N'dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius', 2, 3628.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (8, N'Cockfighter', N'non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus', 1, 3138.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (9, N'Let Fury Have the Hour', N'ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi', 3, 2477.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (10, N'Royal Affair, A (Kongelig affære, En)', N'aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper', 1, 3141.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (11, N'Time Code', N'sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel', 1, 3694.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (12, N'Reefer Madness (a.k.a. Tell Your Children)', N'ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi', 1, 3886.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (13, N'Scary Movie 4', N'pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla', 2, 3855.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (14, N'Kaboom', N'parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida', 3, 2201.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (15, N'Sinbad: The Fifth Voyage', N'nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in', 2, 3112.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (16, N'Bucket List, The', N'interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa', 2, 3289.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (17, N'Burma Conspiracy, The (Largo Winch II)', N'ultricies eu nibh quisque id justo sit amet sapien dignissim', 2, 3600.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (18, N'Anima Mundi', N'eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in', 2, 3497.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (19, N'Eyes of an Angel', N'consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus', 3, 2012.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (20, N'Incendiary', N'dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus', 1, 2896.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (21, N'Just Between Friends', N'consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio', 1, 2454.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (22, N'Ghost, The', N'justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat', 1, 3275.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (23, N'Red 2', N'phasellus in felis donec semper sapien a libero nam dui proin leo', 1, 2960.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (24, N'Bachelor and the Bobby-Soxer, The', N'sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac', 2, 3615.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (25, N'We Are the Best! (Vi är bäst!)', N'at vulputate vitae nisl aenean lectus pellentesque eget nunc donec', 2, 3126.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (26, N'Last Waltz, The', N'ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium', 2, 3345.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (27, N'Is Anybody There?', N'non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', 1, 2248.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (28, N'It''s Pat', N'convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus', 3, 3318.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (29, N'Appleseed (Appurushîdo)', N'vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere', 2, 2711.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (30, N'Stockholm East (Stockholm Östra)', N'amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at', 2, 3132.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (31, N'Skellig', N'nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo', 1, 2195.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (32, N'Bitch Slap', N'lobortis sapien sapien non mi integer ac neque duis bibendum morbi', 2, 2925.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (33, N'Count Yorga, Vampire', N'sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in', 2, 2911.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (34, N'House IV', N'erat volutpat in congue etiam justo etiam pretium iaculis justo in', 3, 3463.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (35, N'Birth of a Nation, The', N'morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede', 3, 2423.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (36, N'The Nautical Chart', N'vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer', 3, 3590.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (37, N'Jupiter Ascending', N'rutrum rutrum neque aenean auctor gravida sem praesent id massa', 3, 3734.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (38, N'Corky Romano', N'semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero', 2, 3230.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (39, N'My Bodyguard', N'integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus', 1, 3688.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (40, N'Time of Favor (Ha-Hesder)', N'eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum', 1, 3841.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (41, N'Scream 4', N'amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor', 1, 2893.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (42, N'Blown Away', N'vel enim sit amet nunc viverra dapibus nulla suscipit ligula in', 3, 3445.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (43, N'Once a Thief (Zong heng si hai)', N'vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam', 3, 3683.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (44, N'Stephanie Daley', N'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus', 3, 2251.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (45, N'All Things Fair (Lust och fägring stor)', N'in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus', 3, 2278.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (46, N'Death Before Dishonor', N'amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu', 2, 2292.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (47, N'Three Brothers (Tre fratelli)', N'vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus', 1, 3510.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (48, N'Chasing Ghosts: Beyond the Arcade ', N'non ligula pellentesque ultrices phasellus id sapien in sapien iaculis', 2, 2496.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (49, N'Million Ways to Die in the West, A', N'erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate', 3, 2451.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (50, N'Just Add Water', N'nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy', 2, 3017.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (52, N'LOL', N'A VERY GOOD MOVIE XD', 1, 150.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (53, N'aaaaaaa', N'aaa', 1, 233.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (55, N'Titanic', N'THIS IS A DESCRIPTION XD', 1, 4678.0000)
INSERT [dbo].[Product] ([IdProduct], [Name], [Description], [IdCategory], [Price]) VALUES (56, N'Lo que el viento se llevo', N'Una buena descripcion!!', 1, 350.0000)
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[Rent] ON 

INSERT [dbo].[Rent] ([IdRent], [IdCustomer], [IdRentStatus], [Date], [ReturnDate], [DueAmount], [DiscountAmount], [TaxAmount], [TotalAmount]) VALUES (1, 15, 2, CAST(N'2017-06-28' AS Date), CAST(N'2017-07-11' AS Date), 43027228.6344, 0.0000, 24535.4400, 160843.4400)
INSERT [dbo].[Rent] ([IdRent], [IdCustomer], [IdRentStatus], [Date], [ReturnDate], [DueAmount], [DiscountAmount], [TaxAmount], [TotalAmount]) VALUES (2, 9, 2, CAST(N'2017-06-08' AS Date), CAST(N'2017-07-20' AS Date), 7810767.0144, 0.0000, 4510.0800, 29566.0800)
INSERT [dbo].[Rent] ([IdRent], [IdCustomer], [IdRentStatus], [Date], [ReturnDate], [DueAmount], [DiscountAmount], [TaxAmount], [TotalAmount]) VALUES (3, 8, 2, CAST(N'2017-06-25' AS Date), CAST(N'2017-07-15' AS Date), 87654283.2266, 0.0000, 50261.2200, 329490.2200)
INSERT [dbo].[Rent] ([IdRent], [IdCustomer], [IdRentStatus], [Date], [ReturnDate], [DueAmount], [DiscountAmount], [TaxAmount], [TotalAmount]) VALUES (4, 2, 2, CAST(N'2017-06-12' AS Date), CAST(N'2017-07-03' AS Date), 29414564.5544, 0.0000, 16589.5200, 108753.5200)
INSERT [dbo].[Rent] ([IdRent], [IdCustomer], [IdRentStatus], [Date], [ReturnDate], [DueAmount], [DiscountAmount], [TaxAmount], [TotalAmount]) VALUES (5, 8, 2, CAST(N'2017-06-02' AS Date), CAST(N'2017-07-27' AS Date), 52293143.7182, 0.0000, 30493.9800, 199904.9800)
INSERT [dbo].[Rent] ([IdRent], [IdCustomer], [IdRentStatus], [Date], [ReturnDate], [DueAmount], [DiscountAmount], [TaxAmount], [TotalAmount]) VALUES (26, 10, 2, CAST(N'2019-06-27' AS Date), CAST(N'2019-06-28' AS Date), 15212.0172, 0.0000, 1045.2600, 6852.2600)
INSERT [dbo].[Rent] ([IdRent], [IdCustomer], [IdRentStatus], [Date], [ReturnDate], [DueAmount], [DiscountAmount], [TaxAmount], [TotalAmount]) VALUES (1006, 3, 3, CAST(N'2019-07-02' AS Date), CAST(N'2019-07-03' AS Date), 3777.4336, 0.0000, 2233.2800, 10209.2800)
INSERT [dbo].[Rent] ([IdRent], [IdCustomer], [IdRentStatus], [Date], [ReturnDate], [DueAmount], [DiscountAmount], [TaxAmount], [TotalAmount]) VALUES (1007, 21, 2, CAST(N'2019-06-20' AS Date), CAST(N'2019-07-03' AS Date), 64354.6624, 0.0000, 38047.5200, 173931.5200)
INSERT [dbo].[Rent] ([IdRent], [IdCustomer], [IdRentStatus], [Date], [ReturnDate], [DueAmount], [DiscountAmount], [TaxAmount], [TotalAmount]) VALUES (1008, 21, 2, CAST(N'2019-06-20' AS Date), CAST(N'2019-07-01' AS Date), 89302.9632, 0.0000, 17599.1200, 80453.1200)
SET IDENTITY_INSERT [dbo].[Rent] OFF
SET IDENTITY_INSERT [dbo].[RentConfig] ON 

INSERT [dbo].[RentConfig] ([IdRentConfig], [Name], [Value]) VALUES (1, N'Tax', 0.2800)
INSERT [dbo].[RentConfig] ([IdRentConfig], [Name], [Value]) VALUES (2, N'RentPerDay', 0.3000)
INSERT [dbo].[RentConfig] ([IdRentConfig], [Name], [Value]) VALUES (3, N'DuePerDay', 0.3700)
SET IDENTITY_INSERT [dbo].[RentConfig] OFF
SET IDENTITY_INSERT [dbo].[RentDetail] ON 

INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (1, 1, 24, 15, 3615.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (2, 3, 32, 14, 2925.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (3, 2, 30, 8, 3132.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (4, 3, 14, 12, 2201.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (5, 3, 47, 13, 3510.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (6, 3, 19, 9, 2012.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (7, 3, 36, 9, 3590.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (8, 5, 19, 5, 2012.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (9, 5, 17, 13, 3600.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (10, 4, 2, 6, 2857.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (11, 3, 44, 11, 2251.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (12, 1, 18, 5, 3497.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (13, 4, 27, 9, 2248.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (14, 5, 27, 15, 2248.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (15, 5, 49, 11, 2451.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (16, 5, 48, 5, 2496.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (17, 5, 37, 5, 3734.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (18, 1, 15, 11, 3112.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (19, 4, 13, 11, 3855.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (20, 1, 4, 14, 2169.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (21, 4, 9, 5, 2477.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (22, 5, 23, 7, 2960.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (23, 3, 15, 7, 3112.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (24, 3, 30, 10, 3132.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (25, 3, 29, 14, 2711.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (26, 1, 16, 5, 3289.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (65, 26, 3, 1, 3638.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (66, 26, 4, 1, 2169.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (1058, 1006, 4, 2, 2169.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (1059, 1006, 3, 1, 3638.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (1060, 1007, 56, 1, 350.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (1061, 1007, 55, 2, 4678.0000)
INSERT [dbo].[RentDetail] ([IdRentDetail], [IdRent], [IdProduct], [Quantity], [Price]) VALUES (1062, 1008, 2, 2, 2857.0000)
SET IDENTITY_INSERT [dbo].[RentDetail] OFF
SET IDENTITY_INSERT [dbo].[RentPayment] ON 

INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (1, 1, 160843.4400, CAST(N'2019-06-30' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (2, 2, 29566.0800, CAST(N'2019-06-30' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (3, 3, 329490.2200, CAST(N'2019-06-30' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (4, 4, 108753.5200, CAST(N'2019-06-30' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (5, 5, 199904.9800, CAST(N'2019-06-30' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (6, 26, 11922.9324, CAST(N'2019-06-30' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (7, 1007, NULL, CAST(N'2019-07-04' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (8, 1007, NULL, CAST(N'2019-07-04' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (9, 1007, NULL, CAST(N'2019-07-04' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (10, 1007, NULL, CAST(N'2019-07-04' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (11, 1006, 13986.7136, CAST(N'2019-07-04' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (12, 1007, NULL, CAST(N'2019-07-04' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (13, 1008, NULL, CAST(N'2019-07-04' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (14, 1008, NULL, CAST(N'2019-07-04' AS Date))
INSERT [dbo].[RentPayment] ([IdRentPayment], [IdRent], [Amount], [Date]) VALUES (15, 1008, NULL, CAST(N'2019-07-04' AS Date))
SET IDENTITY_INSERT [dbo].[RentPayment] OFF
SET IDENTITY_INSERT [dbo].[RentStatus] ON 

INSERT [dbo].[RentStatus] ([IdRentStatus], [Name], [Description]) VALUES (1, N'ACTIVE', N'posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat')
INSERT [dbo].[RentStatus] ([IdRentStatus], [Name], [Description]) VALUES (2, N'PENDING', N'a pede posuere nonummy integer non velit donec diam neque vestibulum eget')
INSERT [dbo].[RentStatus] ([IdRentStatus], [Name], [Description]) VALUES (3, N'COMPLETED', N'nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus')
SET IDENTITY_INSERT [dbo].[RentStatus] OFF
SET IDENTITY_INSERT [dbo].[Stock] ON 

INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (1, 1, 24)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (2, 2, 17)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (3, 3, 23)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (4, 4, 23)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (5, 5, 15)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (6, 6, 25)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (7, 7, 23)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (8, 8, 23)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (9, 9, 19)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (10, 10, 25)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (11, 11, 25)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (12, 12, 18)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (13, 13, 27)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (14, 14, 30)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (15, 15, 25)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (16, 16, 28)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (17, 17, 25)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (18, 18, 26)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (19, 19, 25)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (20, 20, 22)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (21, 21, 21)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (22, 22, 15)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (23, 23, 21)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (24, 24, 22)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (25, 25, 29)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (26, 26, 24)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (27, 27, 30)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (28, 28, 22)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (29, 29, 23)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (30, 30, 18)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (31, 31, 19)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (32, 32, 21)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (33, 33, 17)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (34, 34, 21)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (35, 35, 27)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (36, 36, 26)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (37, 37, 27)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (38, 38, 17)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (39, 39, 22)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (40, 40, 22)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (41, 41, 15)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (42, 42, 25)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (43, 43, 28)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (44, 44, 23)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (45, 45, 29)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (46, 46, 24)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (47, 47, 21)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (48, 48, 26)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (49, 49, 21)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (50, 50, 15)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (52, 52, 34)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (53, 53, 2)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (55, 55, 12)
INSERT [dbo].[Stock] ([IdStock], [IdProduct], [Quantity]) VALUES (56, 56, 8)
SET IDENTITY_INSERT [dbo].[Stock] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__C035B8DD2EF4A0B5]    Script Date: 19/07/05 14:43:18 ******/
ALTER TABLE [dbo].[Customer] ADD UNIQUE NONCLUSTERED 
(
	[DNI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([IdCategory])
REFERENCES [dbo].[Category] ([IdCategory])
GO
ALTER TABLE [dbo].[Rent]  WITH CHECK ADD FOREIGN KEY([IdCustomer])
REFERENCES [dbo].[Customer] ([IdCustomer])
GO
ALTER TABLE [dbo].[Rent]  WITH CHECK ADD FOREIGN KEY([IdRentStatus])
REFERENCES [dbo].[RentStatus] ([IdRentStatus])
GO
ALTER TABLE [dbo].[RentDetail]  WITH CHECK ADD FOREIGN KEY([IdProduct])
REFERENCES [dbo].[Product] ([IdProduct])
GO
ALTER TABLE [dbo].[RentDetail]  WITH CHECK ADD FOREIGN KEY([IdRent])
REFERENCES [dbo].[Rent] ([IdRent])
GO
ALTER TABLE [dbo].[RentPayment]  WITH CHECK ADD FOREIGN KEY([IdRent])
REFERENCES [dbo].[Rent] ([IdRent])
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD FOREIGN KEY([IdProduct])
REFERENCES [dbo].[Product] ([IdProduct])
GO
/****** Object:  StoredProcedure [dbo].[UpdateFineOfRent]    Script Date: 19/07/05 14:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UpdateFineOfRent]
as begin
	set nocount on;
	update R 
		set R.DueAmount = (
		(
			datediff(day, R.ReturnDate, GETDATE())) * (R.TotalAmount * (select Value from RentConfig where Name = 'DuePerDay'))
		) 
	from Rent R
	where R.IdRentStatus = 2
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateRent]    Script Date: 19/07/05 14:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UpdateRent](@idRent int)
as begin
	set nocount on;

	declare @days int = (
		select
			datediff(day, R.Date, R.ReturnDate)
		from Rent R
		where R.IdRent = @idRent
	);

	declare @tax money = (
		select Value from RentConfig where Name = 'Tax'
	);

	declare @subtotal money = (
		select
			sum(RD.Price * RD.Quantity)
		from RentDetail RD
		where RD.IdRent = @idRent
	) * @days;

	declare @taxAmount money = @subtotal * @tax;

	declare @totalAmount money = @subtotal + @taxAmount;

	update R set
		R.TotalAmount = @totalAmount,
		R.TaxAmount = @taxAmount,
		R.DiscountAmount = 0,
		R.DueAmount = 0
	from Rent R
	where R.IdRent = @idRent
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateRentStatus]    Script Date: 19/07/05 14:43:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UpdateRentStatus]
as begin
	set nocount on;
	update Rent set IdRentStatus = 1 where GETDATE() > ReturnDate;
	update Rent set IdRentStatus = 2 where ReturnDate < GETDATE();
	update R set R.IdRentStatus = 3 from Rent R where (R.TotalAmount + R.DueAmount) - (
		select 
			isnull(sum(Amount), 0)
		from RentPayment
		where RentPayment.IdRent = R.IdRent
	) = 0;
end
GO
ALTER DATABASE [Prime] SET  READ_WRITE 
GO
