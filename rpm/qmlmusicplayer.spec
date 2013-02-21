# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.25
# 

Name:       qmlmusicplayer

# >> macros
# << macros

Summary:    Nemo Mobile Music Player
Version:    2.0.1
Release:    1
Group:      Applications/Multimedia
License:    GPLv2
Source0:    %{name}-%{version}.tar.bz2
Source100:  qmlmusicplayer.yaml
BuildRequires:  pkgconfig(QtDeclarative)
BuildRequires:  pkgconfig(phonon)
BuildRequires:  desktop-file-utils
Provides:   org.pycage.musicshelf > 1.0.1
Obsoletes:   org.pycage.musicshelf <= 1.0.1

%description
Music Player for Nemo Mobile


%prep
%setup -q -n %{name}

# >> setup
# << setup

%build
# >> build pre
# << build pre

%qmake 

make %{?jobs:-j%jobs}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%qmake_install

# >> install post
# << install post

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
# >> files
/opt/qmlmediaplayer/bin/qmlmediaplayer
%{_datadir}/applications/qmlmediaplayer.desktop
%{_datadir}/pixmaps/qmlmediaplayer.png
# << files
