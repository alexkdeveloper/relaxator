project ('com.github.alexkdeveloper.relaxator', 'vala', 'c', version: '1.0.0')

gnome = import('gnome')
i18n = import('i18n')

add_project_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language: 'c'
)

asresources = gnome.compile_resources(
    'as-resources',
    join_paths('data', meson.project_name()) + '.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

dependencies = [
    dependency('glib-2.0'),
    dependency('gtk4'),
    dependency('libadwaita-1'),
    dependency('gstreamer-1.0')
]

subdir('src')

executable(
    meson.project_name(),
    sources,
    asresources,
    dependencies: dependencies,
    install: true
)

subdir('data')

gnome.post_install(
  glib_compile_schemas: false,
  gtk_update_icon_cache: true,
  update_desktop_database: true
)
